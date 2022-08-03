#!/bin/bash
# Requires the following to be run before hand
#sudo apt install python3-pip
#pip install awscli
#sudo apt install awscli
# aws configure

git clone $1 code_build_sandbox_folder

#Takes 1 input, the addres to the GitHub Repository
#TODO
# need function from Sunny
for i in /code_build_sandbox_folder/*; do

aws cloudformation deploy --stack-name github-aws-cicd --template-file pipeline.yaml --capabilities CAPABILITY_NAMED_IAM --parameter-overrides GithubRepository=github-aws-cicd
