#!/bin/bash

# This script is a wrapper for calling CFN-NAG against a target repository
# The first argument is a path to the public GitHub repository

# This assumes that CFN-NAG is installed on the host machine
# This can be accomplished with the following steps

# First, ensure apt is updated
#     sudo apt-get update
# Then, install gem and ruby
#     sudo apt-get install gem
#     sudo apt-get install ruby-full
# Then install CFN-NAG
#     sudo gem install cfn-nag

#Takes 1 input, the addres to the GitHub Repository

git clone $1 cfn_nag_sandbox_folder
cfn_nag_scan --input-path cfn_nag_sandbox_folder --output-format json >> "Output/PipelineOutput.txt"