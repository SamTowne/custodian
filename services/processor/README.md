# Processor

Processes policies using cloud custodian module and sends the results to S3.

## Permissions


- S3: write custodian output
- SQS: receive message from queue
- Policy Read Access, must be able to read/list/describe resources as required in the policies configuration
- Policy Write Access, must be able to perform write as required in the policies configuration