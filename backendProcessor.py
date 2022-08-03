import sys
import base64
import json
import subprocess
import os
import time

# This function is designed to handle a Base64 encoded string passed from the front end, containing the order of Pipeline services

def main():
    # Take in the encoded string, decode and split up
    file1 = open("/home/ubuntu/backend/pipeline.txt", "r") 

    passedList = json.loads(base64.b64decode(file1.read()))
    buildList = passedList['Build']
    testList = passedList['Test']
    deployList = passedList['Deploy']

    # Used to keep track of successful scans
    scanCounter = 1
    scanCounter = stageRunner(buildList, scanCounter)
    scanCounter = stageRunner(testList, scanCounter)
    scanCounter = stageRunner(deployList, scanCounter)

    # Append file with the findings
    file1 = open("/home/ubuntu/backend/Output/PipelineOutput.txt", "a+")  # append mode
    file1.write("===================================================================================\n")
    file1.write("PIPELINE IS COMPLETE\n")
    file1.write (str(scanCounter) +" SUCCESSFUL SERVICES RUN\n")
    file1.write("===================================================================================\n")

    #Base64 encode the file
    subprocess.run(["./base64Encoder.sh"])



# This function takes a list of dictionaries, as well as the number of successful scans
def stageRunner(stage, scanCounter):
    for i in stage:
        extractedID = i['id']
        extractedData = i['data']

        # Help formats the output file
        file1 = open("/home/ubuntu/backend/Output/PipelineOutput.txt", "a+")  # append mode
        file1.write("=========================================================================\n")
        file1.write("SCAN NUMBER "+ str(scanCounter - 1) +"\n")
        file1.write("=========================================================================\n")
        file1.close()

        # Check for malformed data
        if extractedData == "":
            print("Misinput - Please provide a directory address")
            continue
            
        # Run Snyk
        if extractedID == '0':
            file1 = open("/home/ubuntu/backend/Output/PipelineOutput.txt", "a+")  # append mode
            file1.write("---SNYK---\n")
            file1.close()

            time.sleep(1)
            subprocess.run(["./snykWrapper.sh", extractedData])
            print("SNYK COMPLETE")
        # Run CodeDeploy
        elif extractedID == '1':
            file1 = open("/home/ubuntu/backend/Output/PipelineOutput.txt", "a+")  # append mode
            file1.write("---CodeDeploy---\n")
            file1.close()
            # TODO
            print("CODEDEPLOY COMPLETE")
        # Run Dependency Check
        elif extractedID == '2':
            file1 = open("/home/ubuntu/backend/Output/PipelineOutput.txt", "a+")  # append mode
            file1.write("---DependencyCheck---\n")
            file1.close()

            subprocess.run(["./dependencyCheckWrapper.sh", extractedData])
            print("DEPENDENCY CHECK SCAN COMPLETE")
        # Run CFN-NAG
        elif extractedID == '3':
            file1 = open("/home/ubuntu/backend/Output/PipelineOutput.txt", "a+")  # append mode
            file1.write("---CFN-NAG---\n")
            file1.close()

            subprocess.run(["./cfn_nagWrapper.sh", extractedData])
            print("CFN-NAG COMPLETE")
        # Run ISM
        elif extractedID == '4':
            file1 = open("/home/ubuntu/backend/Output/PipelineOutput.txt", "a+")  # append mode
            file1.write("---ISM---\n")
            file1.close()
            #TODO
            print("ISM SCAN COMPLETE")

        # Help formats the output file
        file1 = open("/home/ubuntu/backend/Output/PipelineOutput.txt", "a+")  # append mode
        file1.write("=========================================================================\n")
        file1.close()
        scanCounter += 1
    # Return number of successful scans
    return scanCounter        
if __name__=="__main__":
    main()
