##INSTRUCTIONS
1. Clone this repository
2. Download the nexus server linked in the TASK.md and place it into this folder
3. Run the docker.sh script with the neccessary privileges 

##DESCRIPTION
The script will create the neccessary directories if they don't already exist and set the permissions of the host directory to write. It will also build a Docker image and start the container based on the Dockerfile. The container will be set to always start with the OS with the port 18081 binded to the container port 8081 while mounting the host directory to the specified container directory 


