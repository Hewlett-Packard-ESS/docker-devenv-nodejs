#!/bin/bash
export TERM='xterm-256color'
export PATH=./node_modules/.bin:$PATH
source ~/.nvm/nvm.sh
source ~/.bashrc
nvm use 0.10
echo "Now using $(ruby --version)"
echo "Welcome to the HP ESS Development Environment!"

echo $*

if [ "$#" -eq 0 ]; then
  /bin/bash
else
  $*
fi
