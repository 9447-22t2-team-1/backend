aws cloudformation deploy --stack-name github-aws-cicd --template-file pipeline.yaml --capabilities CAPABILITY_NAMED_IAM --parameter-overrides GithubRepository=github-aws-cicd
