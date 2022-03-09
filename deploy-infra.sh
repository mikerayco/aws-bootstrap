#!/bin/bash

STACK_NAME=awsbootstrap
REGION=ap-southeast-1
CLI_PROFILE=personal
EC2_INSTANCE_TYPE=t2.micro

echo -e "\n\n========== deploying main.yaml =========="
aws cloudformation deploy \
    --region $REGION \
    --profile $CLI_PROFILE \
    --stack-name $STACK_NAME \
    --template-file main.yaml \
    --no-fail-on-empty-changeset \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides EC2_INSTANCE_TYPE=$EC2_INSTANCE_TYPE

if [ $? -eq 0 ]; then
    aws cloudformation list-exports \
        --profile personal \
        --query "Exports[?Name=='InstanceEndpoint'].Value"
fi