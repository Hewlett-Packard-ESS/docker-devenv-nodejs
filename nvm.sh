#!/bin/bash
export NVM_DIR=/usr/local/nvm
export NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist
source /opt/nvm/nvm.sh

export NPM_CONFIG_PREFIX=/usr/local/node
nvm use 0.12 2>/dev/null
export PATH="/usr/local/node/bin:$PATH"
