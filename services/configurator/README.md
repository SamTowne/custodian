# Configurator

This lambda function manages the Custodian runtime configuration.

## Example Dynamodb Items

### Policy triggered by cloudtrail events
```yaml
- rule_id: 1
- policy_name: 's3_public_access'
- is_active: true
- take_action: true
- test_mode: false
- triggered_by: [{'cloudtrail': ['event_1', 'event_2']}]
```

### Policy triggered on a recurring schedule
```yaml
- rule_id: 2
- policy_name: 'enforce tagging'
- is_active: true
- take_action: true
- test_mode: false
- triggered_by: [{'scheduled': ['TWENTY_FOUR_HOURS']}]
```

### Permissions
- DynamoDB write
