FROM alpine:3.17

RUN apk add --no-cache\
    'nginx~=1.22' \
    'nginx-mod-http-headers-more==1.22.1-r0' \
    'py3-pip~=22.3.1' &&\
    pip3 install --no-cache-dir \
    j2cli==0.3.10 \
    boto3==1.26.114 &&\
    wget -q "https://github.com/maxcnunes/waitforit/releases/download/v2.4.1/waitforit-linux_amd64" -O /usr/local/bin/waitforit &&\
    chmod +x /usr/local/bin/waitforit &&\
    rm -rf /etc/nginx/nginx.conf /etc/nginx/conf.d/* &&\
    mkdir -p /etc/nginx/conf.d/

COPY ./ /code/
COPY docker-entrypoint.sh aws_sm /usr/local/bin/

EXPOSE 80

ENTRYPOINT ["docker-entrypoint.sh"]
