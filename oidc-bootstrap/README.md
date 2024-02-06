# Bootstrapping trust between a TFC workspace and AWS

[Source](https://github.com/hashicorp/terraform-dynamic-credentials-setup-examples/tree/main/aws)

This directory contains example code for setting up a Terraform Cloud workspace
whose runs will be automatically authenticated to AWS using Workload Identity.

The basic building blocks in `aws.tf` will configure an OIDC provider in AWS
and create a role that is bound to a particular Terraform Cloud workspace.

The building blocks in `tfc-workspace.tf` will create that Terraform Cloud
workspace and set all the configuration variables needed in order to allow runs to authenticate to AWS.

## How to use

You'll need the Terraform CLI installed, and you'll need to set the following environment variables in your local shell:

`TFE_TOKEN` with a Terraform Cloud user token with permission to create workspaces within your organization.

You'll also need to authenticate the AWS provider as you would normally using one of the methods mentioned in the AWS provider documentation [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration).

Make sure the AWS user has at least the following permissions:

```json
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"iam:CreatePolicy",
				"iam:CreateOpenIDConnectProvider",
				"iam:GetOpenIDConnectProvider",
				"iam:GetPolicy",
				"iam:GetPolicyVersion",
				"iam:ListPolicyVersions",
				"iam:DeleteOpenIDConnectProvider",
				"iam:DeletePolicy",
				"iam:CreateRole",
				"iam:GetRole",
				"iam:ListRolePolicies",
				"iam:ListAttachedRolePolicies",
				"iam:ListInstanceProfilesForRole",
				"iam:DeleteRole",
				"iam:AttachRolePolicy",
				"iam:CreatePolicyVersion"
			],
			"Resource": "*"
		}
	]
}
```

Set the credentials via:

```env
export TFE_TOKEN="xxx"

export AWS_ACCESS_KEY_ID="xxx"
export AWS_SECRET_ACCESS_KEY="xxx"
export AWS_REGION="us-west-2"
```

Copy `terraform.tfvars.example` to `terraform.tfvars` and customize the required variables. You can also set values for any other variables you'd like to customize beyond the default.

Run `terraform plan` to verify your setup, and then run `terraform apply`.

Congratulations! You now have a Terraform Cloud workspace where runs will automatically authenticate to AWS when using the AWS Terraform provider.
