# SNS Subscription

Basic quickstart for creating a SNS Subscription resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
module "sns_topic_subscription" {
  source    = "so1omon563/sns/aws//modules/sns_subscription"
  version   = "1.1.0" # Replace with appropriate version
  topic_arn = "<arn_of_sns_topic>"
  protocol  = "sqs"
  endpoint  = "<arn_sqs_queue>"
}
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sns_topic_subscription"></a> [sns\_topic\_subscription](#module\_sns\_topic\_subscription) | so1omon563/sns/aws//modules/sns_subscription | 1.1.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
