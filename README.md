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
