## INSTRUCTIONS
1. Clone this repository
2. Run the setup_docker.sh 
3. To login into the repo manager the credentials are:
##### user: admin
##### pass: a79c460d-bdc5-49ad-a2bc-751668d4b74b

## DESCRIPTION
The script will make sure the neccessary directories exist. It will also build a Docker image and start the container based on the Dockerfile. The container will be set to always start with the OS with on port 18081 binded to the container port 8081 while mounting the host directory to the specified container directory.


