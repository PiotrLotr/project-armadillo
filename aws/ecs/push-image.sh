#!/bin/bash

# Please provide your credentials:
REGION_DEAFULT="eu-central-1"
USERNAME_DEFAULT="AWS"
ACC_NR_DEFAULT="251865263936"

ACC_NR="$ACC_NR_DEFAULT"
REGION="$REGION_DEAFULT"
USERNAME="$USERNAME_DEFAULT"
##############################

# In case of providing different variables than default:
echo "Provide ACC_NR or skip..."
read INPUT
if [ ! -z "$INPUT" ]
then
    ACC_NR="$INPUT"
fi

echo "Provide REGION or skip..."
read INPUT 
if [ ! -z "$INPUT" ]
then
    REGION="$INPUT"
fi

REGISTRY_ID="$ACC_NR.dkr.ecr.$REGION.amazonaws.com"

sudo aws ecr get-login-password --region $REGION | sudo docker login --username $USERNAME --password-stdin $REGISTRY_ID

# TODO: Remove hardcoded part
ECR_NAME="app-prod"
sudo docker build -t $ECR_NAME ./app/app/.
sudo docker tag $ECR_NAME:latest $REGISTRY_ID/$ECR_NAME:latest
sudo docker push $REGISTRY_ID/$ECR_NAME:latest

ECR_NAME="app-dev"
sudo docker build -t $ECR_NAME ./app/app/.
sudo docker tag $ECR_NAME:latest $REGISTRY_ID/$ECR_NAME:latest
sudo docker push $REGISTRY_ID/$ECR_NAME:latest

exit 0