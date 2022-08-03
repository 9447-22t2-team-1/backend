#!/bin/bash

# This script is a wrapper for calling Dependency Check against a target repository
# The first argument is the path to the desired public GitHub

# This assumes that Dependency Check is installed on the host machine
# This can be accomplished with the following steps

#Takes 1 input, the addres to the GitHub Repository

git clone $1 dependency_check_sandbox_folder
./dependency-check.sh --project "Dependency Check" --scan dependency_check_sandbox_folder >> "Output/PipelineOutput.txt"