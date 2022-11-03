# SNS Topic Policy

Basic quickstart for creating a SNS Topic Policy resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
module "sns_topic_policy" {
  source  = "so1omon563/sns/aws//modules/sns_topic_policy"
  version = "1.1.0" # Replace with appropriate version
  arn     = "<arn_of_topic>"
  policy  = "<json_policy_to_attach>"
}
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sns_topic_policy"></a> [sns\_topic\_policy](#module\_sns\_topic\_policy) | so1omon563/sns/aws//modules/sns_topic_policy | 1.1.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
