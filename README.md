# hpess/devenv
This is a container which has all of the tools required to dev in our environment such as:
  - Ruby (with Rake, bundler)
  - node.js (with grunt, jake, npm)

It builds on the foundations of hpess/base

## Use
```
docker run -i -t hpess/devenv
```

And you'll get:
```
HP ESS Development Environment
Node Version: v0.10.33
Ruby Version: ruby 2.0.0p353 (2013-11-22) [x86_64-linux]
```

## Use in a cool, linked up kinda way
If you're wanting to link your devenv to some other containers, and magically grunt it all, i reccomend using fig.   The configuration here defines the devenv, and the mysql server, and links the two.  It mounts our source code into the devenv so everything is ready to rock.
```
devenv:
 hostname: 'devenv'
 image: hpess/devenv
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
fig up -d
fig run devenv grunt watch
```
