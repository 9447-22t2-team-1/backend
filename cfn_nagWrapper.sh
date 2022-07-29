#!/bin/bash

# This script is a wrapper for calling CFN-NAG against a target directory
# The first argument is the path to the desired directory

# This assumes that CFN-NAG is installed on the host machine
# This can be accomplished with the following steps

# First, ensure apt is updated
#     sudo apt-get update
# Then, install gem and ruby
#     sudo apt-get install gem
#     sudo apt-get install ruby-full
# Then install CFN-NAG
#     sudo gem install cfn-nag


prefix="CFN_NagOutput_"         
number=1                           
ext="json"                         

printf -v num "%03d" "$number"      
fname="$prefix$num.$ext"            

while [ -e "CFN_NagOutput/$fname" ]; do 
  echo "abc"
  number=$((number + 1))            
  printf -v num "%03d" "$number"    
  fname="$prefix$num.$ext"          
done


#Takes one argument; the path to the desired directory to be scanned.
mkdir -p CFN_NagOutput
cfn_nag_scan --input-path $1 --output-format json > "CFN_NagOutput/$fname"