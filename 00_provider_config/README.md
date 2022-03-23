# Provider config

Terraform/OpenTofu works with a plugin system for creating resources from different Cloud and SaaS / PaaS providers.
These plugins make calls to the APIs of the providers to create, update and delete the resources you configure
in your HCL code. To be able to use those APIs, however, Terraform/OpenTofu needs access to your credentials (APIs are usually protected),
as well as some other provider specific configuration, e.g. a project name, or the region in which the infrastructure should be deployed.

 To learn about the provider-specific configuration required to use a provider plugin, have a look at the [OpenTofu Registry](https://opentofu.org/docs/) or the [Terraform Registry](https://registry.terraform.io/) for the provider that you want to use.

## Goal of this exercise

The `ssm_parameter.tf` file contains the configuration of a single resource, an SSM parameter (basically a key-value pair stored in the cloud). Try to apply the code as is.
Does it work? How could you improve this piece of code?
