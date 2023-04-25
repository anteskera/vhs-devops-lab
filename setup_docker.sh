#!/bin/bash

# Define the name and tag for the Docker image
IMAGE_NAME="my-nexus-image"
IMAGE_TAG="latest"

# Define the name for the Docker container
CONTAINER_NAME="nexus"

# Define the Nexus home directory
NEXUS_HOME="/opt/nexus"

PARENT_HOST_DIR="/tn_devops"
# Define the host directory to mount as the Nexus data directory
HOST_DIR="/tn_devops/nexus"

if [ -d "$PARENT_HOST_DIR" ]; then
  echo "$PARENT_HOST_DIR directory already exists"
else
  echo "Creating $PARENT_HOST_DIR directory"
  sudo mkdir "$PARENT_HOST_DIR"
fi

if [ -d "$HOST_DIR" ]; then
  echo "$HOST_DIR directory already exists"
else
  echo "Creating $HOST_DIR directory"
  sudo mkdir "$HOST_DIR"
fi

sudo chown $USER:$USER $HOST_DIR

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
  --restart=always \
  --mount type=bind,source=$HOST_DIR,target=$NEXUS_HOME/sonatype-work \
  -p 18081:8081 \
  "$IMAGE_NAME:$IMAGE_TAG"

# Check if the Docker container was started successfully
if [ $? -eq 0 ]; then
  echo "Docker container '$CONTAINER_NAME' was started successfully."
else
  echo "Failed to start Docker container '$CONTAINER_NAME'."
  exit 1
fi
