# Cheat sheet

This cheatsheet contains the most commonly used Hashicorp Configuration Language (HCL) syntax, which might come in handy during the exercises. HCL is shared between Terraform and OpenTofu.

## Resources, data sources and modules

### Resources

Resources are the most fundamental objects within HCL; they are the building blocks which you can use to build your infrastructure. Resources have input arguments that you use to configure them, and have output arguments or so-called attributes which you can use to configure other resources and create implicit dependencies. You use them as follows:

```terraform
resource "cloud_resource" "my_resource" {
    arg1 = x
}
```

Here you are creating an instance of a `cloud_resource` type resource (which should be documented in a provider doc), and you give it the name `my_resource` which you can use to refer to this instance in other parts of your code. Resources are namespaced by their type (note that this is an important difference with other Terraform/OpenTofu types!). You can refer to an attribute of a resource (to configure another resource, or to use an `output`, see below) as follows:

`cloud_resource.my_resource.property`

This resolves into the `attribute` attribute of the `cloud_resource` type that you named `my_resource` in your code.

### Data sources

Note that data sources, like resources, are objects that have attributes that contain the data you are likely interested in. As for resources, you can find the list of attributes of a data source in the [OpenTofu Registry](https://opentofu.org/docs/) or [Terraform Registry](https://registry.terraform.io/).

```terraform
data "cloud_data_source" "my_data_source" {
    arg1 = x
}
```

Data sources have their own namespace, meaning that you can reference them as follows: `data.cloud_data_source.my_data_source.property`, which extracts the `property` attribute of the `cloud_data_source` that is known to Terraform/OpenTofu as `my_data_source`.

### Modules

Modules are directories containing files with `.tf` prefixes, and can be instantiated in other modules as follows:

```terraform
module "my_module" {
    source = "./my_module_folder"
    var1 = x
    var2 = y
    var3 = z
}
```

You can reference modules and the outputs that they contain in a separate `module` namespace. E.g.: `module.my_module.my_module_output` refers to the `my_module_output` output defined in the module.

---

## Variables, locals and outputs

### Variables

You can define variables as follows:

```terraform
variable "my_variable" {
    type = list(string)
    default = ["Hello", "world!"]
}
```

They can be referenced via the `var` namespace as follows: `var.my_variable`. Arguments such as `type` and `default` are optional. For a complete list of (optional) variable arguments, have a look at the [official docs](https://opentofu.org/docs/language/values/variables/).

### Locals

You can define one or more `local` values in a `locals` scope:

```terraform
locals {
    my_first_local = "my_first_local_value"
    my_second_local = 42
}
```

and they can be referenced as follows: `local.my_first_local`. Notice that you define them as `locals`, but the namespace they reside in is called `local` (without the extra 's').

### Outputs

Outputs of a module can be defined as follows

```terraform
output "my_output" {
    value = "my_output_value"
}
```

For root modules (i.e. the directory in which you run `tofu init/plan/apply`), the output values are printed to `stdout`. For nested modules you can refer to the output of that modules as e.g. `module.my_module.my_output`.

---

## Iteration

### *over resources*

#### Count

The `count` meta-argument expects an integer as its value, specifying the number of copies of an object you want to create. You can refer to the current iteration within the scope of the resource/data source/module you are creating by means of a `count` object, which has a `index` attribute.

Example:

```terraform
resource "cloud_resource" "my_resource" {
    count = 5
    name = "my-resource-${count.index}"
}

```

#### For each

A more flexible iteration meta-argument is `for_each` which takes as an input a set, or a map (if you want to use a list, have a look at the `toset` function). You can refer to the keys and/or values in that set/map within the scope of the resource/data source/module you are creating with the `each` keyword.

Example:

```terraform
resource "cloud_resource" "my_resource" {
    for_each = {key1: "value1", key2: "value2"}
    name = each.key
    value = each.value
}

```

### *over iterables*

### For

You can create new iterables (lists, sets, objects, maps) by iterating over another iterable with the `for` keyword. E.g.
`[for s in var.list : upper(s)]` creates a new list by uppercasing the strings `s` in the variable `list`.

For other use cases, have a look at the official [HCL docs](https://opentofu.org/docs/language/expressions/for/).

---

## Conditional expressions

Terraform/OpenTofu allows you to conditionally define or instantiate things with its ternary operator. The expression `condition? true_val: false_val` evaluates to `true_val` if `condition` is an expression that evaluates to `true`, otherwise it evaluates to `false_val`.

A very common usage pattern of the ternary operator is to combine it with the count meta-argument to optionally instantiate a resource/data source/module based on some `condition`:

```terraform
resource "cloud_resource" "my_resource" {
    count = condition? 1: 0
}
```

This snippet only instantiates a `cloud_resource` when the `condition` evaluates to `true`.
