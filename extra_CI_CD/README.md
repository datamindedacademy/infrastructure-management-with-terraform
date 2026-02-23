# Continuous integration / continuous development

Although you can easily set up and manage infrastructure in the Cloud by manually applying your Terraform/OpenTofu code
from your development machine, it is considered best practice to automate (part of) the deployment via a
continuous integration / continuous deployment (CI/CD) pipeline.

Applying infrastructure code via CI/CD allows you to run `tofu apply` on a schedule, or whenever you merge a development branch into `main`
and minimizes the 'drift' between the actual infrastructure and the infrastructure defined in the
state file. Drift occurs when resources change without there being code changes, for example when someone makes changes
via the AWS Console or the AWS CLI.

## Goal of this exercise

In this exercise, you will complete a GitHub Action workflow that is defined in the `.github` directory.
This CI/CD pipeline should consist of four steps:
1. Install the latest version of OpenTofu (this step we already included for you)
2. Format the code and fail if it is incorrectly formatted (`tofu fmt` all the things!)
3. Pull in the required providers, initialize modules (if any) and configure the remote backend
4. Automatically apply your code

You don't have to provide any AWS credentials or profiles; your instructor already configured those as 
GitHub actions secrets for the remote repository. The CI/CD pipeline will use those secrets as environment variables,
which Terraform/OpenTofu automatically picks up. 

**! IMPORTANT !**

In order not to annoy the other participants, make sure that you either
- cloned the repo, so that your pipeline is isolated from those of the other participants
- create a new branch, copy and rename the `tf_cicd.yml`, and set the trigger branch to the name of your new branch instead of `main`, so that you have a unique pipeline that only gets triggered whenever you push your changes.