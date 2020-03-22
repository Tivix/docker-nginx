docker-nginx
============

A meant-for-docker, nginx-based, HTTP proxy for serving static files, forwarding requests to upstreams, as well as local development.

USAGE
-----
```
proxy:
  image: tivix/docker-proxy
  build:
    context: .
  ports:
    - 127.0.0.1:80:80
  environment:
    - UPSTREAMS=/api:backend:8000,/:frontend:80
    - STATICS=/static:/data/static
```

Some of the envrionment variables available:
- `UPSTREAMS=/:backend:8000` a comma separated list of \<path\>:\<upstream\>:\<port\>.  Each of those of those elements creates a location block with proxy_pass in it.
- `STATICS=/static:/data/static` a comma separated list of \<path\>:\<directory\>. Creates a location block with `alias` directive.
- `HTTPS_REDIRECT=true` enabled a standard, ELB compliant https redirect.
- `BASIC_AUTH_ALL=true` enables a catch-all basic auth protection. Must be used in conjuction with BASIC_AUTH_USER and BASIC_AUTH_PASS (or AWS Secrets Manager, see below)
- `BASIC_AUTH_LOCATIONS=/api` enables basic auth protection for selected locations. The paths must be declared in UPSTREAMS first.
- `AWS_SECRET_PATH` and `AWS_SECRET_KEY` will get the basic auth password from AWS Secrets Manager. Requires standard AWS API access, either via Instance Profile or API keys.
```
AWS_SECRET_PATH=staging
AWS_SECRET_KEY=NGINX_PASSWORD
AWS_DEFAULT_REGION=us-west-1
```
The above will get the password from AWS Secret Manager secret named `staging`, and extract the value of `NGINX_PASSWORD` from it.
- `GZIP=true` enables standard GZIP compression with some sane defaults
- `REAL_IP=true` enables parsing of X-Forwarded-For header.
- `REAL_IP_HEADER=X-Real-Ip` customizes which header to use for real_ip
- `REAL_IP_CIDRS=10.0.0.0/8,192.168.0.0/16` sets the set_real_ip_from directive
- `MICROCACHE=true` enables "microcaching". Nginx will cache upstream responses for short ammount of time.
- `MICROCACHE_TIMEOUT` how long to cache responses for. Defaults to 1s.
- `DEBUG` makes things verbose
- `DEV_SSL_CERT` somewhat hacky for now. Adds a `ssl on` listen directive with (currently) hardcoded, self-signed certificate.
- `WORKER_PROCESSES=auto` number of nginx processes. Access the same values as worker_processes directive.
- `UWSGI=true` switches proxy_pass to uwsgi_pass
- `STATS=true` enables nginx stats endpoint under `/nginx_status`
- `HEALTHCHECK=true` enables simple healthcheck endpoint under `/nginx_health`

...and some others. See the code.
