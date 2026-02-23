# Passing information between States

Sometimes you want to pass a piece of information from one Terraform/OpenTofu state to another. Consider for example a large organization,
which works in multiple teams; one team might be responsible for setting up the networking configuration (VPC, subnets, security groups, VPC endpoints, ...),
and another might build a data processing platform on top of that base infrastructure (e.g. an EMR or Kubernetes cluster).
When deploying their infrastructure, the team working on the processing platform will need as inputs the VPC and subnet ids
that the platform team created.

## Goal of this exercise

We have created a database and EC2 instance within this module. As the database will likely require fewer updates than the server that is running a client-facing app,
the core infrastructure team (team 1) decided that it's better to split up these components in a different state, managed by different teams.

It is your task to perform this state separation and provide the information that the application team (team 2) needs from team 1,
i.e. the address of the database and the port that it's listening on. As we've seen in the theory lectures, this can be done in two different ways,
i.e. with a remote state data source, or via cloud-specific resources such as e.g. SSM Parameters in AWS.
Try out both methods and discuss their advantages and disadvantages.
