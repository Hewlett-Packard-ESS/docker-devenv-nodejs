#!/bin/bash
hash nvm &> /dev/null
if [ $? -eq 1 ]; then
  CURRENT="none"
else
  CURRENT=$(nvm current) 2>/dev/null
fi

if [ "$CURRENT" == "none" ]; then
  export NVM_DIR=/usr/local/nvm
  source /opt/nvm/nvm.sh

  export NPM_CONFIG_PREFIX=/usr/local/node
  export PATH="/usr/local/node/bin:$PATH"
  nvm use 0.10 2>/dev/null 2>&1
fi
