# tf-cloud-aws

Learn TF with TF Cloud on AWS, including best practices and code analysis via
GH actions.

## tfswitch

[The tfswitch command line tool lets you switch between different versions of terraform.](https://tfswitch.warrensbox.com/)
This allows you to use the same exact version of Terraform as the repository you are working in.
Especially in larger multi-repository code bases, updates often happend gradually.

Follow the [installation instructions](https://tfswitch.warrensbox.com/Install/).

Then run `tfswitch` from the root of this repository.
The required version will be discovered from the Terraform files, in this case [main.tf](main.tf).

There also exists [`tfenv`](https://github.com/tfutils/tfenv), but it has not been released since `tfenv` July 2022.

## tflint

[TFLint](https://github.com/terraform-linters/tflint), is a Pluggable Terraform Linter.

It provides plugins for use with Terraform cloud providers, e.g., [AWS](https://github.com/terraform-linters/tflint-ruleset-aws).

Follow the [installation instructions](https://github.com/terraform-linters/tflint?tab=readme-ov-file#installation).

See [.tflint.hcl](.tflint.hcl) on how to configure TFLint.

Run `tflint --init` to download any configured plugins.

Run `tflint` to check for any problems. For example when using an unknown EC2 instance type:

```sh
$ tflint
1 issue(s) found:

Error: "t2.mega" is an invalid value as instance_type (aws_instance_invalid_type)

  on main.tf line 41:
  41:   instance_type          = "t2.mega"
```

TFLint also provides a [setup GH Action](https://github.com/terraform-linters/setup-tflint).
See [tflint.yml](.github/workflows/tflint.yml).

## TODO: OPA policies with Styra

A [Terraform Tutorial](https://developer.hashicorp.com/terraform/tutorials/automation/validation-enforcement)
explains how to enfore
[OPA policies](https://www.openpolicyagent.org/docs/latest/policy-language/)
in your Terraform files using
[Styra](https://signup.styra.com/).
