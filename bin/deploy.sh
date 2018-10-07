#!/bin/bash

rm -Rf handler.zip main  eks-workshop-temp

BUCKET_NAME=eks-workshop-lambda
GOOS=linux go build main.go

zip handler.zip ./main

aws s3 cp handler.zip s3://$BUCKET_NAME/handler.zip
