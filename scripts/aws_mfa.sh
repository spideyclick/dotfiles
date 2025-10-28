#!/bin/bash
# Credit to Jake for this one!

if [ $# -ne 1 ]; then
    echo "Usage: awslogin <mfa-token-code>"
    echo "Example: awslogin 123456"
    exit 1
fi

#MFA_DEVICE_ARN=""
TOKEN_CODE="$1"

echo "Getting session token..."
OUTPUT=$(aws sts get-session-token \
    --serial-number "$MFA_DEVICE_ARN" \
    --token-code "$TOKEN_CODE" 2>&1)

if [ $? -ne 0 ]; then
    echo "Error getting session token:"
    echo "$OUTPUT"
    exit 1
fi

ACCESS_KEY_ID=$(echo "$OUTPUT" | jq -r '.Credentials.AccessKeyId')
SECRET_ACCESS_KEY=$(echo "$OUTPUT" | jq -r '.Credentials.SecretAccessKey')
SESSION_TOKEN=$(echo "$OUTPUT" | jq -r '.Credentials.SessionToken')
EXPIRATION=$(echo "$OUTPUT" | jq -r '.Credentials.Expiration')

if [ "$ACCESS_KEY_ID" = "null" ] || [ "$SECRET_ACCESS_KEY" = "null" ] || [ "$SESSION_TOKEN" = "null" ]; then
    echo "Error parsing AWS response"
    exit 1
fi

export AWS_ACCESS_KEY_ID="$ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$SECRET_ACCESS_KEY"
export AWS_SESSION_TOKEN="$SESSION_TOKEN"

# Display results
echo "AWS credentials set successfully!"
echo "Expiration: $EXPIRATION"

