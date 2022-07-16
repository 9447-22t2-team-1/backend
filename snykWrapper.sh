#!/bin/bash

# This script is a wrapper for calling snyk against a target directory

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

snyk test --json > "SnykOutput/$fname"