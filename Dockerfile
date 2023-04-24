# Use an existing image as a base
FROM registry.access.redhat.com/ubi8/ubi:8.7

# Install any necessary dependencies
RUN yum install -y java-1.8.0-openjdk-devel

ENV NEXUS_HOME /opt/nexus

# Copy the Nexus bundle to the container
COPY nexus-3.37.3-02-unix.tar.gz .

# Create the NEXUS_HOME directory
RUN mkdir $NEXUS_HOME

# Unpack the Nexus bundle into the NEXUS_HOME folder
RUN tar xvf nexus-3.37.3-02-unix.tar.gz -C $NEXUS_HOME

# Expose a port for the container
EXPOSE 8080

# Set the default working directory to NEXUS_HOME
WORKDIR $NEXUS_HOME

# Define a volume mount point for the /opt/nexus/sonatype-work directory
VOLUME $NEXUS_HOME/sonatype-work

# Define the command to run when the container starts
CMD ["nexus-3.37.3-02/bin/nexus", "start"]