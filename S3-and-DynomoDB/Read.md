****Terraform lock ****

Terraform Lock prevents multiple people (or CI/CD pipelines) from running terraform apply simultaneously, avoiding state file corruption.

Terraform lock, using DynamoDB it will check any one work on project , as soon as run command terraform apply , it check any hold the lock ID . Based on it will modify the terraform state file.

DynamoDB temporarily stores a simple lock record before granting access to the S3 state file.


**How Dynomo DB work in real time**

DynamoDB temporarily stores a simple lock record before granting access to the S3 state file.
When a user runs terraform apply, DynamoDB creates a temporary LockID and stores it in the DynamoDB database—
For example:
{"LockID": "your/state/terraform.tfstate", "Info": "user@host PID"}.

Once the user completes the task or modification, it updates the S3 Terraform state file and deletes the DynamoDB lock record.

If another user tries to access the state file while the first user is working (lock exists), DynamoDB blocks them from modifying it. 

Access is only granted once the first user completes the task or the lock record is deleted from the database.



 




**We implementing locking mechanism using Dynomo DB, We need to created Amazon DynamoDB**

what is dynamo DB
DynamoDB is AWS's fully managed NoSQL database for fast, scalable storage of key-value and document data.
It auto-scales to handle heavy traffic without servers to manage, perfect for apps like gaming or e-commerce.

DynamoDB Advantages
DynamoDB offers high availability, 
low-latency performance, scalability, 
seamless AWS integration without needing self-management.
It's reliable for distributed locking across multiple users or CI/CD pipelines, with automatic lock expiration on failures

What is NoSQL
NoSQL databases often store data as JSON documents (or similar formats like BSON), especially document-based ones like MongoDB. This makes them flexible for semi-structured data without needing fixed schemas.
Your statement is mostly correct—JSON format enables easy handling of nested objects, arrays, and varying fields, unlike rigid SQL tables.

Why we are using dynamo DB in terraform locking process why can't go for other database.
DynamoDB is used for Terraform state locking because it's AWS-managed, fast, scalable, and handles concurrent checks reliably without setup hassle.
It prevents concurrent terraform apply runs by creating/deleting lock records reliably, avoiding state corruption without extra setup.


**Let’s setup the Dynomo DB for locking terraform state file in S3**

resource "aws_dynamodb_table" "this" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {

name = "terraformstate-lock"
}


name = "terraform-locks"
 creates the DynamoDB table name that holds temporary LockID records during terraform apply.

hash_key = "LockID" 
is the required partition key name for Terraform state locking.
Simple reason: Terraform always looks for exactly "LockID" to check/create/delete locks.
Each state file = 1 unique LockID value: "eks/prod/terraform.tfstate"
what happen we didn't mention this
Terraform fails immediately with error:
Error: Lock table missing LockID hash key


billing_mode = "PAY_PER_REQUEST"
     means pay only for actual reads/writes - no capacity planning needed.
When run the command terraform apply.

attribute {
name = "LockID"
type = "S"
}

defines the partition key for the DynamoDB table.
name = "LockID"  → Required exact name (Terraform hardcoded)
type = "S"              → String data type (holds paths like "eks/prod/terraform.tfstate")
Purpose: Terraform uses this key to quickly check/create/delete lock records during apply.
Without it: Table creates but locking fails - "missing LockID attribute" error.

We have created dynamo DB , it’s okay name is different.

 

**.terraform.tfstate.lock.info **
Explained
Purpose
Temporary file Terraform creates to lock your state file during plan/apply, preventing concurrent changes.
Problem
Stuck if process crashes (Ctrl+C, disconnect); blocks future runs.
Fix
Confirm no other Terraform running
Delete .terraform.tfstate.lock.info (and .terraform.tfstate.lock)
Or: terraform force-unlock [ID from file]

Note
Only local backends; use S3+DynamoDB for teams.

**.terraform.lock.hcl **
Explained

Purpose
Records exact provider versions + hashes for consistent Terraform runs across machines/teams. Like package-lock.json.
When Created
Auto-generated/updated by terraform init.
Best Practice
Commit to Git for reproducibility. Don't edit manually.

Note
Ensures everyone uses identical provider versions, preventing surprises.

