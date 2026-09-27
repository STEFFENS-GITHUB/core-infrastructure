## Prerequisites

These resources are not managed by this repo and must exist before running Terraform.

- A terraform S3 state bucket per environment
- A root hosted zone for the specified domain.
- A github environment with TERRAFORM_CI_ROLE_ARN set per desired env.