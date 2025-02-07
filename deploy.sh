#!/bin/bash

# Variables
KEY_PATH="~/Downloads/myfirstkey911.pem"  
USER="ec2-user"
HOST="3.111.53.45"                       
LOCAL_DIR="/Users/suhaibkhan/Desktop/practicepw/src"     # Local directory
REMOTE_DIR="/home/ec2-user"              # Remote directory on EC2
JAR_NAME="HelloWorld.jar"

echo "Step 1: Compiling Java Program..."
cd $LOCAL_DIR
javac -source 17 -target 17 HelloWorld.java

echo "Step 2: Creating JAR File..."
jar cfm $JAR_NAME manifest.txt HelloWorld.class

echo "Step 3: Transferring JAR to EC2..."
scp -i $KEY_PATH $LOCAL_DIR/$JAR_NAME $USER@$HOST:$REMOTE_DIR

echo "Step 4: Running JAR on EC2..."
ssh -i $KEY_PATH $USER@$HOST "cd $REMOTE_DIR && java -jar $JAR_NAME"

echo "Deployment Complete!"

