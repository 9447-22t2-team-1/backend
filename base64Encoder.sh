#!/bin/bash
cat Output/PipelineOutput.txt | base64 -w 0 > Output/PipelineOutputEncoded.txt