# custodian

Serverless deployment of Cloud Custodian

## Roadmap

1. package cloud custodian processor service using github actions, the package needs to be formatted for aws lambda consumption
1. deploy package to aws using code deploy
1. cloud custodian policies to turn off expensive things during off hours
1. support multiple runtime modes (scheduled, event-driven, on-demand)