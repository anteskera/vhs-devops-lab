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
  echo "Creating $PARENT_HOST_DIR directory "
  mkdir "$PARENT_HOST_DIR"
fi

if [ -d "$HOST_DIR" ]; then
  echo "$HOST_DIR directory already exists"
else
  echo "Creating $HOST_DIR directory "
  mkdir "$HOST_DIR"
fi

echo "Setting $HOST_DIR directory permissions to write"
chmod u+w $HOST_DIR


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
  -p 18081:8081 \
  "$IMAGE_NAME:$IMAGE_TAG"

# Check if the Docker container was started successfully
if [ $? -eq 0 ]; then
  echo "Docker container '$CONTAINER_NAME' was started successfully."
else
  echo "Failed to start Docker container '$CONTAINER_NAME'."
  exit 1
fi
