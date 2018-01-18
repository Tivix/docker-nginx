FROM alpine:3.7

RUN apk add --update-cache nginx py-pip bash curl

RUN pip install j2cli

ADD nginx.conf.j2 /nginx.conf.j2
ADD nginx-site.conf.j2 /nginx-site.conf.j2
ADD uwsgi_params /uwsgi_params
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
