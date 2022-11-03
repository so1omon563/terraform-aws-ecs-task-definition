# SNS Platform Application

Basic quickstart for creating a SNS Platform Application resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
module "sns_platform_application" {
  source              = "so1omon563/sns/aws//modules/sns_platform_application"
  version             = "1.1.0" # Replace with appropriate version
  name                = "example-application"
  platform            = "<platform>"
  platform_credential = "<private_key_for_platform>"
}
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sns_platform_application"></a> [sns\_platform\_application](#module\_sns\_platform\_application) | so1omon563/sns/aws//modules/sns_platform_application | 1.1.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
