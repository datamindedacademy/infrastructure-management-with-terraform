# Conditional infrastructure

Most data platforms have multiple so-called 'environments' which are used to build, test and run data pipelines and/or products.
It is a good practice to make these environments as similar as possible, so that you can be confident when you
deploy to production that nothing will break.

Sometimes, however, you might want to deploy only a part of your infrastructure,
or be a little more frugal on the amount of resources you allocate to a certain environment.

Terraform/OpenTofu allows you to conditionally deploy infrastructure with its ternary conditional operator:

`condition ? value_if_true : value_if_false`

## Goal of this exercise

You will write a module from scratch (or rather, from boilerplate) containing infrastructure that you then should deploy in a test and production environment.
You can reuse some existing infrastructure (a VPC, subnet, security group and IAM role) via the ssm parameters defined in `module/ssm_parameters.tf`

### S3 bucket

- we want to create and manage a KMS key to encrypt the data in our bucket *only* in production. For the test environment,
the AWS managed S3 key (or even AES256 encryption) will do just fine.

- we want to enable versioning of S3 objects *only* in the production environment

- the production S3 bucket should only be accessible from the VPC subnets. For the test environment, access control can be less strict.
We might want to upload public datasets to the bucket to train a ML model.

### SageMaker Notebook instance

- In production, we want to have a notebook instance with a GPU. For the test environment, a small t2 or t3 instance can save us
some money.

- We also want to disable root access to the Notebook in production
