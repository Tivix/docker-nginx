docker-nginx
============

Nginx based proxy meant to work with uwsgi upstream or proxy_pass

[![Codefresh build status]( https://g.codefresh.io/api/badges/build?repoOwner=Tivix&repoName=docker-nginx&branch=master&pipelineName=docker-nginx&accountName=tivix&key=eyJhbGciOiJIUzI1NiJ9.NTgzNDViNTkyZWRiOGYwMTAwZTllYWNk.N-gEtemnze6Sz5dmxpN0dcZ8Ev6oSdyiXDpbCy_TClI&type=cf-1)]( https://g.codefresh.io/repositories/Tivix/docker-nginx/builds?filter=trigger:build;branch:master;service:5a6097ecd6addc0001813e45~docker-nginx)

Variables
---------

_/vars with default values/_

UPSTREAM_BACKEND=localhost
UPSTREAM_BACKEND_PORT=8000
UPSTREAM_BACKEND_TIMEOUT=5s
UPSTREAM_BACKEND_FAILS=6
NGINX_PORT=80
NGINX_SERVER_NAME='_'
PROXY_TARGET_URL=localhost
PROXY_TARGET_PORT=8080
USE_UWSGI=false
USE_STATICS=false
