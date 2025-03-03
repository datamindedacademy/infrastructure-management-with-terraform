# Infrastructure Management with Terraform on AWS

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/datamindedacademy/better-infrastructure-management-with-terraform)

## Getting started

You can do the exercises either on your local machine with your IDE of choice, or use a preconfigured Gitpod Cloud development environment (see below). If you'd like to
try out Gitpod, you can skip the Terraform installation step below.

### Install Terraform

To install Terraform, we recommend using a version manager such as tfswitch or tfenv.

On MacOS and Linux systems, you can install them with brew:

`brew install warrensbox/tap/tfswitch` or `brew install tfenv`

On Windows there is currently no widely adopted Terraform version manager. You can install a specific version `x.y.z` of Terraform with Chocolately:

`choco install terraform --version=x.y.z`

For the exercises, we'll be using Terraform versions `>=1.0.0`

### Use Gitpod

Create a free Gitpod account at [gitpod.io](https://www.gitpod.io). You can then open the exercise repository in a cloud IDE via the badge under the header of this README.

This will set up a preconfigured development environment for you, which includes both `tfswitch` and the `awscli`.

## Configure AWS credentials

In order for Terraform to deploy infrastructure on AWS, Terraform needs to make authenticated API requests on your behalf.
You will receive an `AWS_ACCES_KEY_ID` and `AWS_SECRET_ACCESS_KEY` from the instructor.

First make sure that you have the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
installed. Then run `aws configure --profile academy` and fill in the access keys and configure the region and output format as follows:

```bash
aws configure --profile academy
AWS Access Key ID [None]: $YOUR_ACCES_KEY_ID
AWS Secret Access Key [None]: $YOUR_SECRET_ACCES_KEY
Default region name [None]: eu-west-1
Default output format [None]: json
```

## Ready... Set... Go

You should now be able to start with the exercises. `cd` your way into the first exercise folder (`00_provider_config`), read the instructions in the `README.md` and try to write some Terraform code to solve the problem. Don't worrry, the majority of the code you can find in or adapt from the [Terraform provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)! Good luck, and remember: `terrafrom init`, `terraform plan`, and `terrafrom apply` all the things!

P.S.: Exercise `06_existing_infra` is by far the most difficult one. Feel free to skip it initially and come back to it at the end, in case there is still some time left.
