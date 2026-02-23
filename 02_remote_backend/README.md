# Remote backend

Terraform/OpenTofu keeps track of the infrastructure it is managing in a state file. By default, it
stores this state file locally, next to the files in which you define your infrastructure. This makes collaboration on a
common set of infrastructure more difficult, as you would need sync the local state files of each individual collaborator.

A solution to this problem is the use of a remote backend, containing a single state file, i.e., a single source of truth.
In AWS, the most commonly used remote backend is S3. The S3 backend supports native state locking to avoid concurrency issues.

## Goal of this exercise

Set up a secure remote S3 backend with versioning and encryption.

1. `cd` into the `remote_setup` folder and `tofu apply` the infrastructure. Note that to set up the remote backend, you will have to use a local state (as there is no remote backend yet, right?).
2. Navigate back to the root directory of the exercise and complete the `backend "s3"` block in `provider.tf` with the bucket name and other settings from step 1.

For inspiration and additional hints, have a look at the official [OpenTofu documentation](https://opentofu.org/docs/language/settings/backends/s3/) for the S3 backend.

> **Note:** `terraform` commands work identically if you prefer to use Terraform instead.
