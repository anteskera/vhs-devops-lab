#!/bin/bash

# Define the name and tag for the Docker image
IMAGE_NAME="my-nexus-image"
IMAGE_TAG="latest"

# Define the name for the Docker container
CONTAINER_NAME="nexus"

# Define the Nexus home directory
NEXUS_HOME="/opt/nexus"

# Define the host directory to mount as the Nexus data directory
HOST_DIR="/tn_devops/nexus"

if [ -d "/tn_devops" ]; then
  echo "/tn_devops directory already exists"
else
  echo "Creating tn_devops directory "
  mkdir "/tn_devops"
fi

if [ -d "/tn_devops/nexus" ]; then
  echo "/tn_devops/nexus directory already exists"
else
  echo "Creating /tn_devops/nexus directory "
  mkdir "/tn_devops/nexus"
fi

# Build the Docker image
docker build -t "$IMAGE_NAME:$IMAGE_TAG" .

# Check if the Docker image was built successfully
if [ $? -eq 0 ]; then
  echo "Docker image '$IMAGE_NAME:$IMAGE_TAG' was built successfully."
else
  echo "Failed to build Docker image '$IMAGE_NAME:$IMAGE_TAG'."
fi

# Start the Docker container with the specified settings
docker run -d \
  --name "$CONTAINER_NAME" \
  -v "$HOST_DIR:$NEXUS_HOME/sonatype-work" \
  --restart=always \
  -p 18081:8080 \
  "$IMAGE_NAME:$IMAGE_TAG"

# Check if the Docker container was started successfully
if [ $? -eq 0 ]; then
  echo "Docker container '$CONTAINER_NAME' was started successfully."
else
  echo "Failed to start Docker container '$CONTAINER_NAME'."
  exit 1
fi
