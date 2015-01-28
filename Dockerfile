FROM hpess/devenv:latest
MAINTAINER Karl Stoney <karl.stoney@hp.com>

RUN git clone --depth=1 https://github.com/creationix/nvm.git /opt/nvm && \
    mkdir -p /usr/local/nvm && \
    mkdir -p /usr/local/node && \
    chown -R docker:docker /usr/local/node && \
    chown -R docker:docker /usr/local/nvm && \
    chown -R docker:docker /opt/nvm

ADD nvm.sh /etc/profile.d/nvm.sh

ENV NVM_DIR /usr/local/nvm
ENV NPM_CONFIG_PREFIX /usr/local/node
ENV PATH "/usr/local/node/bin:$PATH"

# Install version 0.10.x of node
RUN su - docker -c 'nvm install 0.10' && \
    su - docker -c 'npm install -g grunt-cli jake forever js-beautify'

# Install JQ to help with JSON command line parsing
RUN cd /tmp && \
    wget --quiet --connect-timeout 7 http://stedolan.github.io/jq/download/source/jq-1.4.tar.gz && \
    tar zxvf jq-1.4.tar.gz && \
    cd jq-1.4 && \
    ./configure && \
    make && \
    make install && \
    cd /tmp && \
    rm -rf jq-1.4

# Add the cookbooks
COPY cookbooks/ /chef/cookbooks/

# Set the chef local run list
ENV chef_node_name devenv.docker.local
ENV chef_run_list $chef_run_list,npm 
