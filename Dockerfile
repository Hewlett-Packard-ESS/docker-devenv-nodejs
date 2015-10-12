FROM hpess/devenv:master
MAINTAINER Karl Stoney <karl.stoney@hp.com>

# Corkscrew for tunnling ssh over https
RUN cd /tmp && \
    wget http://agroman.net/corkscrew/corkscrew-2.0.tar.gz && \
    tar -xvzf corkscrew-* && \
    cd corkscrew-* && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/corkscrew*

# NVM for node management
RUN git clone --depth=1 https://github.com/creationix/nvm.git /opt/nvm && \
    mkdir -p /usr/local/nvm && \
    mkdir -p /usr/local/node && \
    chown -R docker:docker /usr/local/node && \
    chown -R docker:docker /usr/local/nvm && \
    chown -R docker:docker /opt/nvm

# Install the node mocha template
RUN mkdir -p /home/docker/.grunt-init && \
    git clone https://github.com/Stono/grunt-init-node-mocha.git /home/docker/.grunt-init/node-mocha && \
    chown -R docker:docker /home/docker/.grunt-init

# Install JQ to help with JSON command line parsing
RUN yum install -y jq

ADD nvm.sh /etc/profile.d/nvm.sh

ENV NVM_DIR /usr/local/nvm
ENV NPM_CONFIG_PREFIX /usr/local/node
ENV PATH "/usr/local/node/bin:$PATH"

RUN su - docker -c 'nvm install 0.12' && \
    su - docker -c 'nvm use 0.12 && npm install -g https://github.com/Hewlett-Packard-ESS/nsp.git npm grunt-cli grunt-init npm-check-updates depcheck grunt-cli jake forever js-beautify node-inspector'

# Setup the super awesome node profiler...
RUN yum -y install perf && \
    yum -y clean all

# Now get flamegraph
RUN cd /usr/local/src && \
    wget --quiet https://github.com/brendangregg/FlameGraph/archive/master.tar.gz && \
    tar -xzf master.tar.gz && \
    rm master.tar.gz && \
    mv FlameGraph* flamegraph

# And finally add the script
COPY node-profile /usr/local/bin/node-profile

# Add the cookbooks
COPY cookbooks/ /chef/cookbooks/

# Set the chef local run list
ENV chef_node_name devenv.docker.local
ENV chef_run_list $chef_run_list,npm 
