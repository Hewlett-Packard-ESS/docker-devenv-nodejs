FROM hpess/devenv:latest
MAINTAINER Karl Stoney <karl.stoney@hp.com>

# Some bits that node-gyp etc use
RUN yum -y install gcc-c++ gcc make && \
    yum -y clean all

# Install nvm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash

# Configure nvm and node
RUN source ~/.nvm/nvm.sh && \
    nvm install 0.10 && \
    source ~/.bashrc && \
    nvm use 0.10 && \ 
    npm install -g grunt-cli jake forever && \
    echo 'nvm use 0.10' >> ~/.bashrc
