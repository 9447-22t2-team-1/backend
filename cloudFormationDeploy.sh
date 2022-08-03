#!/bin/bash
# Requires the following to be run before hand
#sudo apt install python3-pip
#pip install awscli
#sudo apt install awscli
# aws configure

if [ $# -ne 1 ]
then
    echo "usage: $(basename "$0") <github repo link>" >&2
    exit 1
fi

repo_link="$1"
repo_name='code_build_sandbox_folder'

if ! git clone "$repo_link" "$repo_name"
then
    echo "error cloning $repo_link" >&2
    exit 2
fi

# find the first .yaml or .yml file in the top level of the repo and assume it is the cf template
for file in "$repo_name"/*
do
    # check if the folder is empty
    if [ "$file" = "${repo_name}/*" ] && [ ! -f "${repo_name}/*" ]
    then
        break
    fi

    if echo "$file" | grep -E '\.(yaml|yml)$' > /dev/null
    then
        aws cloudformation deploy --stack-name github-aws-cicd --template-file "$file"  --capabilities CAPABILITY_NAMED_IAM --parameter-overrides GithubRepository=github-aws-cicd
        # exit with the status of the aws command
        exit $?
    fi
done

echo 'could not find cloud formation template ending with .yaml or .yml' >&2
exit 3

