# hpess/devenv-nodejs
This container is a development environment for nodejs, expanding on the framework of hpess/devenv by installing the tools required to develop in node:
 - nvm (default install v0.10.33)
 - grunt, jake, forever

## Use
fig.yml:
```
devenv:
  image: hpess/devenv-nodejs
  environment:
    - ROOT_PASSWORD=secret
  ports:
    - '8022:22'
```
or in line:
```
docker run -p 8022:22 hpess/devenv
```
results in:
```
devenv_1 | ***************************************************
devenv_1 | *  Welcome to the HP ESS Development Environment!  
devenv_1 | ***************************************************
devenv_1 |  => You did not specify a command to run, therefore starting supervisor and sshd
devenv_1 |  => You can login via ssh with username: root, password: secret
devenv_1 |  => Wemux users can login with username: devenv, password: devenv
devenv_1 | 2014-12-11 16:38:44,898 CRIT Set uid to user 0
devenv_1 | 2014-12-11 16:38:44,898 WARN Included extra file "/etc/supervisord.d/sshd.service.conf" during parsing
devenv_1 | 2014-12-11 16:38:44,939 INFO RPC interface 'supervisor' initialized
devenv_1 | 2014-12-11 16:38:44,939 CRIT Server 'unix_http_server' running without any HTTP authentication checking
devenv_1 | 2014-12-11 16:38:44,939 INFO supervisord started with pid 11
devenv_1 | 2014-12-11 16:38:45,945 INFO spawned: 'sshd' with pid 14
devenv_1 | 2014-12-11 16:38:47,110 INFO success: sshd entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
```
You can specify an exact command to run if you dont want to start sshd, etc
```
docker run hpess/devenv-nodejs grunt
```
This is an example fig file where I link this container to a mysql container, and run a bunch of tests:
```
devenv:
 hostname: 'devenv'
 image: hpess/devenv-nodejs
 command: /bin/true
 ports: 
  - '8022:22'
 volumes: 
  - ./:/storage
 links:
  - mysql:mysql

mysql:
 hostname: 'mysql'
 image: hpess/mysql
 environment:
  - MYSQL_PASS=password
```
Whenever you run a command on devenv, it'll auto start mysql as it's linked.
Here is an example of running a one off grunt (note, i'm sleeping for 10s to give mysql chance to start....)
```
fig up -d && sleep 10 && fig run --rm devenv grunt --force && fig stop && fig rm --force
```
It's worth taking not of the fig stop, and fig rm --force at the end.  This will clean up the containers from your system after they've been run as you don't really want to keep them.

Watching works perfectly fine too, for example:
```
fig run devenv grunt watch
```
Results in:
```
[root@fedora opsview]# fig run devenv grunt watch
***************************************************
*  Welcome to the HP ESS Development Environment!  
***************************************************
Now using node v0.10.33
 => Executing: grunt watch
Running "watch" task
Waiting...
```
