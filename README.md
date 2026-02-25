# Infrastructure Management with OpenTofu on AWS

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/datamindedacademy/infrastructure-management-with-terraform)

## Getting started

You can do the exercises either on your local machine with your IDE of choice, or use a preconfigured GitHub Codespaces cloud development environment (see below). If you'd like to use Codespaces, you can skip the OpenTofu installation step below.

### Install OpenTofu

[OpenTofu](https://opentofu.org/) is an open-source fork of Terraform that is fully compatible with existing Terraform code and providers. It is the recommended tool for this course.

To install OpenTofu, we recommend using a version manager such as `tofuenv`:

On MacOS and Linux systems, you can install it with brew:

`brew install tofuenv`

Then install the desired version:

`tofuenv install 1.11.5 && tofuenv use 1.11.5`

Alternatively, if you prefer Terraform, you can use `tfenv` or `tfswitch`:

`brew install tfenv` or `brew install warrensbox/tap/tfswitch`

On Windows, you can install OpenTofu via the [official installer](https://opentofu.org/docs/intro/install/). For Terraform, use Chocolatey:

`choco install terraform --version=x.y.z`

For the exercises, we'll be using Terraform/OpenTofu versions `>= 1.6`.

### Use GitHub Codespaces

You can open the exercise repository in a cloud IDE via the badge under the header of this README. This will set up a preconfigured development environment for you, which includes both `tofu`, `terraform` and the `awscli`.

## Configure AWS credentials

In order for OpenTofu to deploy infrastructure on AWS, it needs to make authenticated API requests on your behalf.
You will receive an `AWS_ACCES_KEY_ID` and `AWS_SECRET_ACCESS_KEY` from the instructor.

First make sure that you have the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
installed. Then run `aws configure --profile academy` and fill in the access keys and configure the region and output format as follows:

```bash
aws configure --profile academy
AWS Access Key ID [None]: $YOUR_ACCES_KEY_ID
AWS Secret Access Key [None]: $YOUR_SECRET_ACCES_KEY
Default region name [None]: eu-west-1
Default output format [None]: json
```

## Ready... Set... Go

You should now be able to start with the exercises. `cd` your way into the first exercise folder (`00_provider_config`), read the instructions in the `README.md` and try to write some HCL code to solve the problem. Don't worry, the majority of the code you can find in or adapt from the [OpenTofu Registry](https://opentofu.org/docs/) or the [Terraform provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)! Good luck, and remember: `tofu init`, `tofu plan`, and `tofu apply` all the things!

> **Note:** All exercises use standard HCL and are compatible with both Terraform and OpenTofu. If you prefer Terraform, simply replace `tofu` with `terraform` in all commands.

P.S.: Exercise `06_existing_infra` is by far the most difficult one. Feel free to skip it initially and come back to it at the end, in case there is still some time left.
