# Use an existing image as a base
FROM registry.access.redhat.com/ubi8/ubi:8.7

# Install any necessary dependencies
RUN yum install -y java-1.8.0-openjdk-devel wget

# Create a non-login user with a home directory
RUN useradd -m -s /sbin/nologin nexus

# Set a password for the new user
RUN echo "anypass" | passwd nexus --stdin

# Add the new user to the sudoers group
RUN usermod -aG wheel nexus

ENV NEXUS_HOME /opt/nexus

# Create the NEXUS_HOME directory
RUN mkdir $NEXUS_HOME

RUN wget https://download.sonatype.com/nexus/3/nexus-3.37.3-02-unix.tar.gz

# Unpack the Nexus bundle into the NEXUS_HOME folder
RUN tar xvf nexus-3.37.3-02-unix.tar.gz -C $NEXUS_HOME

RUN chown -R nexus:nexus $NEXUS_HOME

# Switch to the new user
USER nexus

# Expose a port for the container
EXPOSE 8081

# Set the default working directory to NEXUS_HOME
WORKDIR $NEXUS_HOME

# Define a volume mount point for the /opt/nexus/sonatype-work directory
VOLUME $NEXUS_HOME/sonatype-work

# Define the command to run when the container starts
CMD ["./nexus-3.37.3-02/bin/nexus", "run"]
