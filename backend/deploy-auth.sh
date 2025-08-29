#!/bin/bash
echo "Deploying auth stack..."
aws cloudformation deploy \
  --template-file auth.yaml \
  --stack-name aws-serverless-shopping-cart-auth \
  --capabilities CAPABILITY_NAMED_IAM \
  --region us-east-1 \
  --no-fail-on-empty-changeset

if [ $? -eq 0 ]; then
    echo "Auth stack deployed successfully!"
else
    echo "Auth stack deployment failed!"
    exit 1
fi