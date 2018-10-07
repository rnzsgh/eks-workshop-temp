#!/bin/bash

# Usage: bin/create.sh GITHUB_TOKEN_ID

STACK_NAME=eksw-0

# ##############################################################################
# Location

REGION=us-east-1
AZ_0=us-east-1a
AZ_1=us-east-1b
AZ_2=us-east-1d

# ##############################################################################
# IAM - The admin user must be a valid IAM user

ADMIN_USER=ryan
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

ADMIN_ROLE_ARN=arn:aws:iam::$ACCOUNT_ID:role/TestAdmin

# TODO - ensure Create the admin role that the CloudFormation will run under

# ##############################################################################
# Misc

AWS_PROFILE=default

LAMBDA_S3_BUCKET=eks-workshop-lambda

KEY_NAME=rnzdev

# ##############################################################################
# GitHub

GIT_REPO=eks-workshop-sample-app
GIT_BRANCH=master

# If the repo is a GitHub organization, use that name instead of GitHub user.
GITHUB_USER=rnzsgh

# Credentials for a user who has permission in GitHub organization.
GITHUB_TOKEN=$1

# ##############################################################################

# VPC
 aws cloudformation create-stack \
--region $REGION \
--stack-name $STACK_NAME \
--role-arn $ADMIN_ROLE_ARN \
--template-body file://templates/stack.cfn.yml \
--profile $AWS_PROFILE \
--capabilities CAPABILITY_NAMED_IAM \
--parameters \
ParameterKey=AvailabilityZone1,ParameterValue=$AZ_0 \
ParameterKey=AvailabilityZone2,ParameterValue=$AZ_1 \
ParameterKey=AvailabilityZone3,ParameterValue=$AZ_2 \
ParameterKey=KeyName,ParameterValue=$KEY_NAME \
ParameterKey=AdminRoleArn,ParameterValue=$ADMIN_ROLE_ARN \
ParameterKey=AdminUser,ParameterValue=$ADMIN_USER \
ParameterKey=LambdaBucket,ParameterValue=$LAMBDA_S3_BUCKET \
ParameterKey=GitSourceRepo,ParameterValue=$GIT_REPO \
ParameterKey=GitBranch,ParameterValue=$GIT_BRANCH \
ParameterKey=GitHubUser,ParameterValue=$GITHUB_USER \
ParameterKey=GitHubToken,ParameterValue=$GITHUB_TOKEN \

