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


prefix="SnykOutput_"         
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

snyk auth f2e2f17a-4a38-44a2-98f2-00ffe3c664bc
mkdir -p SnykOutput
#Takes 1 input, a address to a public GitHub Repository
snyk test $1 --json > "SnykOutput/$fname"