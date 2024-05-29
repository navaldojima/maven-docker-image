# Use an official Maven image as a parent image
FROM maven:3.8.5-openjdk-11

# Install Docker
USER root
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release apt-utils && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Define working directory
WORKDIR /usr/src/app

# Copy the rest of your application code
COPY . .

# Run Maven to build the application
RUN mvn clean package

# Entry point for the container
CMD ["mvn", "clean", "package"]