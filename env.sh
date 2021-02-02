#!/bin/bash
export SERVICE_NAME=test-service
export APP_TYPE=java
export AWS_REGION=ap-south-1
export ROLE=application
export KEEP_ECR_IMAGES=5
export BRANCH=$(git rev-parse --abbrev-ref HEAD)
export VERSION=$(git rev-parse --short HEAD)
export REPOSITORY_URI=090436275138.dkr.ecr.${AWS_REGION}.amazonaws.com/${SERVICE_NAME}

