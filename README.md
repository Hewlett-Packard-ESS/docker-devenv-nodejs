# hpess/devenv-nodejs
This container is a development environment for nodejs, expanding on the framework of [hpess/devenv](https://github.com/Hewlett-Packard-ESS/docker-devenv) by installing the tools required to develop in node:
 - nvm (default install node v0.10.35)
 - grunt, jake, forever

## Use
The easiest way is probably with a fig file, as you need to pass in some environment variables to configure things.

fig.yml:
```
devenv:
  image: hpess/devenv
  ports:
    - "2022:2022"
  environment:
    devenv_password: 'password'
    devenv_wemux_password: 'password'
    git_name: "Mr Example"
    git_email: "mr.example@domain.com"
    git_ssl_verify: "false"
    npm_registry: "http://registry.npmjs.org"
    npm_ssl_verify: "false"
  volumes:
    - /path/to/your/code/:/storage
```
A breakdown here:
  - The passwords are used to control SSH and Wemux access to the environment.  Not required, will just default if they need to.
  - Git details, again if you're not using git, they're not required.  git_ssl_verify will allow connections to https sources with invalid certificates
  - Npm details, again, not required.
  - Volumes: Mount your source code to /storage as that's the working directory.

## SSH Agent Forwarding
If you want to pass through your SSH identity, so that you can use git in the docker container with your credentials, use SSH Agent Forwarding:
```
ssh -T devenv@127.0.0.1 -p 2022
```
## Even easier use
If, like me, you work behind a corporate firewall etc sometimes - you might want to take a look at [hpess/dockerproxy](https://github.com/Hewlett-Packard-ESS/docker-proxy)
