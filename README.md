# tf-cloud-aws

Learn TF with TF Cloud on AWS, including best practices and code analysis via
GH actions.

## Auth Terraform Cloud <-> AWS

Hashicorp provides a [tutorial](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/aws-configuration)
to configure dynamics provider credentials for AWS when using Terraform Cloud.

We have copies their [AWS example code](https://github.com/hashicorp/terraform-dynamic-credentials-setup-examples/tree/main/aws)
to out local [oidc-bootstrap](./oidc-bootstrap/README.md) folder, and set the
configuration according our environment.

## Auth GitHub <-> Terraform Cloud

GitHub and Terraform Cloud may be connected [through different configurations](https://developer.hashicorp.com/terraform/tutorials/cloud/github-oauth):
* [per-GitHub-organization](https://developer.hashicorp.com/terraform/cloud-docs/vcs/github)
* [per Repository](https://developer.hashicorp.com/terraform/cloud-docs/vcs/github-app)

In any case, the connection is [owned by a single user and their token](https://github.com/hashicorp/terraform-provider-tfe/issues/96#issuecomment-1237220872).
Also [documented in Terraform docs (Step 2)](https://developer.hashicorp.com/terraform/cloud-docs/vcs/github)

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

## tfsec

[tfsec](https://aquasecurity.github.io/tfsec/latest/) is a static analysis security scanner for your Terraform code.

False positives can be ignored using [inline annotations](https://aquasecurity.github.io/tfsec/latest/guides/configuration/ignores/)
or a [config file](https://aquasecurity.github.io/tfsec/latest/guides/configuration/config/).

tfsec provides guidance to [integrate into GitHub actions](https://aquasecurity.github.io/tfsec/latest/guides/github-actions/github-action/) using SARIF files.

[GitHub Code Scanning](https://docs.github.com/en/code-security/code-scanning/introduction-to-code-scanning/about-code-scanning) has to be [enabled for the repository](https://github.com/datosh/tf-cloud-aws/security/code-scanning).

Aqua encourages users to [migrate to Trivy](https://aquasecurity.github.io/tfsec/latest/guides/trivy/).

## TODO: checkov

https://github.com/bridgecrewio/checkov

## TODO: terrascan

https://github.com/tenable/terrascan

## TODO: OPA policies with Styra

A [Terraform Tutorial](https://developer.hashicorp.com/terraform/tutorials/automation/validation-enforcement)
explains how to enfore
[OPA policies](https://www.openpolicyagent.org/docs/latest/policy-language/)
in your Terraform files using
[Styra](https://signup.styra.com/).

## TODO: Is it possible to limit which VCS show up in TF Cloud?

I can see ControlPlane & WildWest when I
[link VCS](https://app.terraform.io/app/datosh/workspaces/tf-cloud-aws/settings/version-control).
Can I link it?

## TODO: Branching strategy

Currently I only commit to `main` this makes SCA in GH Action & Terraform Cloud deploy run in parallel.
Ideally, branch runs only plan & SCA, main runs only deploy.
