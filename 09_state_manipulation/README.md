# State manipulation

Like an accountant, Terraform/OpenTofu diligently keeps track of the infrastructure it created for you in the state file.
In most scenario's, you don't need to interact with the state yourself.

Sometimes, however, you do need to get your hands dirty and perform some 'surgery' on the state file. In this exercise,
you'll see some common cases of when and how to do this.

## Goal of this exercise

To see what you can do with the state, have a look at the output of `tofu state --help`.

For each scenario below, there are two approaches:

- **CLI approach**: use `tofu state` subcommands to manipulate the state directly
- **Declarative approach**: use [`removed`](https://opentofu.org/docs/language/resources/syntax/#removing-resources), [`import`](https://opentofu.org/docs/language/import/), or [`moved`](https://opentofu.org/docs/language/modules/develop/refactoring/) blocks in your HCL code

Try both and discuss their trade-offs!

### 1. Remove a resource from state

The S3 bucket you created as a data scientist in the `s3.tf` file should be managed by the platform team, so that they can control the
data access permissions. As the bucket already contains some valuable data, you don't want to delete it. Remove the bucket
from your state file, without destroying the actual resource.

### 2. Import existing infrastructure

Your team has been using an SQS queue to process incoming data events. The queue was originally created by a colleague via the AWS Console (try to create one yourself! If you get stuck, ask the course assistant to help you). Now you're asked to bring this queue under infrastructure-as-code management, without disrupting the messages already in the queue.

### 3. Move resources into a module

In exercise 4, you created a module from scratch. As with normal code, however, such abstractions (and modules are abstractions!) are not always obvious
from the start. More often than not, you will have to move code around, and restructure along the way. As Terraform/OpenTofu interprets each folder with .tf files as a module,
moving resources into a new module deletes the resource and then recreates it. But what if that resource is crucial to the operations of your
organization, and has to run with zero downtime? Imagine for example that the notebook defined in `notebook_instance.tf` is running a heavy ML training job for days on end.
You want to refactor it together with the `ssm_parameters.tf` config into a module ASAP, without having to wait for the training job to finish.
How can you do this? Apply the resources in this directory, and then migrate them to a new module.

**! IMPORTANT !**

Replace `$yourname` in the `provider.tf` backend config to your own name!
