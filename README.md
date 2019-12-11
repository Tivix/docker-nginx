docker-nginx
============

Nginx based proxy meant to work with uwsgi upstream or proxy_pass

[![Codefresh build status]( https://g.codefresh.io/api/badges/build?repoOwner=Tivix&repoName=docker-nginx&branch=master&pipelineName=tivix%2Fdocker-nginx&accountName=tivix&type=cf-1)]( https://g.codefresh.io/repositories/Tivix/docker-nginx/builds?filter=trigger:build;branch:master;service:5a6097ecd6addc0001813e45~tivix/docker-nginx)

USAGE
-----
`docker run -d -p 9080:80 tivix/docker-nginx`
will start nginx server and server static help page

`docker run -d -p 9080:80 -e "PROXY_TARGETS=target1:8080,target2:8081" -e "PROXY_LOCATIONS=/,target2" tivix/docker-nginx`
will start nginx and create two location blocks:
- one for root (where forward to target1 host will be put)
- second for target2 (where forward to target2 host will be put)

Variables
---------

_/vars with default values/_

- UPSTREAMS="name:url:port" (accepts multiple values /comma separated/; it also assumes that upstream is served by uwsgi)
- UPSTREAMS_LOCATIONS="/" (accepts multiple values /comma separated/; root by default; defines nginx location block for URI; order has to be equal to one from UPSTREAMS)
- UPSTREAMS_TIMEOUT=5 (default)
- UPSTREAMS_FAILS=6 (default)
- NGINX_PORT=80 (default)
- NGINX_SERVER_NAME=_ (default)
- PROXY_TARGETS="url:port" (accepts multiple values /comma separated/)
- PROXY_LOCATIONS="/" (accepts multiple values /comma separated/; root by default; defines nginx location block for URI; order has to be equal to one from PROXY_TARGETS )
- STATICS=false
- STATICS_LOCATION=statics
- STATS=false (internal nginx_stats on/off)
- USE_AUTH=false (basic auth on/off)
- AUTH_USER="user_name"
- AUTH_PASS="password"
- BUFFER_OFF="false" (if true it disables proxy_buffering)
- REAL_IP

Options
-------

### basic auth
- USE_AUTH=false
- AUTH_USER=
- AUTH_PASS=

### turn on internal nginx stats
- USE_STATS=false
- STATS_PORT=9080

### turn on OAUTH option _/use in connection with external OAUTH container/_
- USE_OAUTH=false
- OAUTH_URL=127.0.0.1
- OAUTH_PORT=4180
- OAUTH_NGINX_PORT=80
