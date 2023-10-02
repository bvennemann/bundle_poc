FROM python:3.11
RUN apt-get update 
RUN apt-get -y install curl
RUN curl -fsSL https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh | sh
RUN echo ls
RUN echo databricks --version
