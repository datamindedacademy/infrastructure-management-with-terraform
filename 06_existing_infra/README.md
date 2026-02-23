# Existing infra

In the previous exercises, you mainly created infrastructure from scratch. In the real world, however,
you're more likely to maintain and extend an already existing infrastructure codebase (so called 'brownfield projects'). And although
this code can be syntactically correct, and can be applied successfully, it does not necessarily mean that it works as intended...

## Goal of this exercise

You're one of the infrastructure engineers in your firm. Last week, your colleague had dealt with a user request:

> Provide notebook instance for exploratory analysis of data in S3.
>
> Please provide a Sagemaker notebook instance so that anyone who is authorized to use the notebook may access data in
> the S3 bucket "dm-academy-course-data".

Your colleague completed the request. But today you are notified that the end user cannot read the contents
of `s3://dm-academy-course-data-$yourPetName/data/trees.csv` (`yourPetName` is the random id that OpenTofu generates for you via the `random_pet` resource in the `random.tf` file.). The notification did not contain the computer generated error message or
any other more helpful information.

Your job is to investigate and resolve.

Before you start, brainstorm with the instructor:

- what reasons can you think of that this could be happening?
- for each reason, think of a method to verify and resolve.
- what would you need to do as a last step to say that you're done?

Then, actually start by applying the code with `tofu apply`. You can use the url in the output to open the Notebook
Instance, or connect to it via the AWS Console.

## Background

Students get access to some HCL code that deploys

- a notebook
- an IAM role
- a VPC
- a VPC subnet
- a VPC endpoint
- an S3 bucket

They should login via the AWS Console to their Notebook and try to access a blob in S3 (either with AWS CLI, or boto3)
and validate the claim. They should then study the error message to start resolving the issue.

!To make sure you have a state of your own, change `$YOURNAME` on line 12 of the `provider.tf` file to your own name!
