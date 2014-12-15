FROM hpess/devenv:latest
MAINTAINER Karl Stoney <karl.stoney@hp.com>

# Install nvm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash
RUN source ~/.nvm/nvm.sh && nvm install 0.10

# Configure some node bits
RUN source ~/.bashrc && nvm use 0.10 && npm install -g grunt-cli jake forever
RUN echo 'nvm use 0.10' >> ~/.bashrc
