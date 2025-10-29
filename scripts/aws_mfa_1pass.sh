#!/bin/bash
# This script is also from Jake but uses 1Password

check_cached_credentials() {
    CACHED_EXPIRATION=$(op item get "AWS Session" --fields label=Expiration)
    
    if [ "$CACHED_EXPIRATION" = "none" ]; then
        return 1  # No expiration found in cache
    fi
    
    # Convert dates to epoch time for comparison
    CACHED_EXPIRATION_EPOCH=$(date -d "$CACHED_EXPIRATION" +%s 2>/dev/null)
    CURRENT_EPOCH=$(date +%s)
    
    # Check if cached credentials have expired (with 5 minute buffer)
    BUFFER_SECONDS=300
    if [ $((CACHED_EXPIRATION_EPOCH - BUFFER_SECONDS)) -gt $CURRENT_EPOCH ]; then
        echo "Using cached AWS credentials (expires: $CACHED_EXPIRATION)"
        
        export AWS_ACCESS_KEY_ID=$(op item get "AWS Session" --fields label=username)
        export AWS_SECRET_ACCESS_KEY=$(op item get "AWS Session" --fields label=password)
        export AWS_SESSION_TOKEN=$(op item get "AWS Session" --fields label=SessionToken)
        
        return 0  # Cached credentials are valid
    else
        echo "Cached credentials have expired, requesting new ones..."
        return 1  # Cached credentials expired
    fi
}

# Check cached credentials first
if check_cached_credentials; then
    exit 0
fi

# If we get here, we need new credentials
#MFA_DEVICE_ARN=""
read -p "Enter your AWS 2FA Code: " TOKEN_CODE

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

op item edit "AWS Session" "username=$ACCESS_KEY_ID" > /dev/null 2>&1
op item edit "AWS Session" "password=$SECRET_ACCESS_KEY" > /dev/null 2>&1
op item edit "AWS Session" "SessionToken=$SESSION_TOKEN" > /dev/null 2>&1
op item edit "AWS Session" "Expiration=$EXPIRATION" > /dev/null 2>&1

if [ "$ACCESS_KEY_ID" = "null" ] || [ "$SECRET_ACCESS_KEY" = "null" ] || [ "$SESSION_TOKEN" = "null" ]; then
    echo "Error parsing AWS response"
    exit 1
fi

# Export credentials for current session
export AWS_ACCESS_KEY_ID="$ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$SECRET_ACCESS_KEY"
export AWS_SESSION_TOKEN="$SESSION_TOKEN"

CurrentDate=$(date -u)

# Display results
echo "AWS credentials set successfully!"
echo "Expiration: $EXPIRATION"
echo "CurrentTime: $CurrentDate"
echo "Credentials cached to: $CACHE_FILE"
