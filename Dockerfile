FROM alpine:3.7

RUN apk add --update-cache nginx py-pip bash curl openssl

RUN pip install j2cli

ADD nginx.conf.j2 /nginx.conf.j2
ADD nginx-site.conf.j2 /nginx-site.conf.j2
ADD uwsgi_params /uwsgi_params
ADD index.html.j2 /index.html.j2
ADD entrypoint.sh /entrypoint.sh

ENV WAITFORIT_VERSION="v2.2.0"
RUN curl -o /usr/local/bin/waitforit -sSL https://github.com/maxcnunes/waitforit/releases/download/$WAITFORIT_VERSION/waitforit-linux_amd64 && \
    chmod +x /usr/local/bin/waitforit

RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
