#!/bin/bash

# This script is a wrapper for calling snyk against a target directory

# This assumes that Snyk CLI is installed on the host machine
# This can be accomplished with the following steps

# First, ensure Node.js is installed
#     sudo apt install nodejs
# Then, use Node.js to install Snyk CLI
#     sudo npm install snyk -g
# Users must authenticate this CLI with their existing Snyk accounts
#     snyk auth [<API_TOKEN>]


prefix="${1:-SnykOutput_}"         
number=1                           
ext="json"                         

printf -v num "%03d" "$number"      
fname="$prefix$num.$ext"            

while [ -e "SnykOutput/$fname" ]; do 
  echo "abc"
  number=$((number + 1))            
  printf -v num "%03d" "$number"    
  fname="$prefix$num.$ext"          
done

mkdir -p SnykOutput
snyk test --json > "SnykOutput/$fname"