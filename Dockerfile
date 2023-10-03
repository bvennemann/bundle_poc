# This Dockerfile defines a Docker image that is used as execution environment
# for the Jenkins Agent. It includes all dependencies that are needed for the
# CI/CD workflow.

# Start from a python base image
FROM python:3.11

# Install curl
RUN apt-get update 
RUN apt-get -y install curl

# Install the Databricks CLI
RUN curl -fsSL https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh | sh

# Install Python dependencies
COPY jenkins-requirements.txt jenkins-requirements.txt
RUN python -m pip install --upgrade pip
RUN pip install -r jenkins-requirements.txt