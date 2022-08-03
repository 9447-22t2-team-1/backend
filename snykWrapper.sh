#!/bin/bash

# This script is a wrapper for calling snyk against a target repository

# This assumes that Snyk CLI is installed on the host machine
# This can be accomplished with the following steps

# First, ensure Node.js is installed
#     sudo apt install nodejs
# Then, use Node.js to install Snyk CLI
#     sudo npm install snyk -g
# Users must authenticate this CLI with their existing Snyk accounts
#     snyk auth [<API_TOKEN>]

snyk auth f2e2f17a-4a38-44a2-98f2-00ffe3c664bc
#Takes 1 input, the addres to the GitHub Repository

snyk test $1 --json >> "Output/PipelineOutput.txt"