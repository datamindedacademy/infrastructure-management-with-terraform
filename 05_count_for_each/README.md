# Count / For Each

Sometimes you want to deploy multiple instances of the same resource, or even an entire module. Terraform/OpenTofu has two main
syntactical features that allows you to do just that, while keeping your code DRY: `count` and `for_each`.

`count` expects as input an integer, which can be referenced in the resource scope as `count.index`

`for_each` expects as input a map or a set, whose keys and values can be referenced as `each.key` and `each.value`

## Goal of this exercise

In this exercise you will provide the new batch of data scientists that your company recently hired with their own secure SageMaker
notebook instance (using the module that you created in the previous exercise).

Your manager forwarded you the names of the new
colleagues, their preferred instance type (some are more senior than others), and the IP address from which they will be able to SSH into
their instance:

- Users: ["Alice", "Bob", "Chris", "Diana", "Erin"]
- Instance type: ["ml.t2.medium", "ml.m4.xlarge", "ml.t2.medium", "ml.t3.medium", "ml.t2.medium"]
- IP: ["1.1.1.1", "1.1.1.2", "1.1.1.3", "1.1.1.4", "1.1.1.5"]

You should try to do this in three different ways:

1. Use these lists in combination with the `count` argument to deploy the notebooks. What happens when you re-order the lists and apply again?
2. Convert the lists into a map structure and use `for_each` instead. Why is this often a better solution than `count`?
3. Create a yaml or csv file containing the notebook configuration information for each data scientist, and use
some of the [built-in functions](https://opentofu.org/docs/language/functions/) to parse the file and create a succesful `tofu plan`. You don't need to apply the resources (think about the climate!).

HINT: to debug reading in and transforming the data in your yaml/csv/txt file into a map or list, you can make use of the `tofu console`, which gives you an interactive REPL in which you can test HCL code.
