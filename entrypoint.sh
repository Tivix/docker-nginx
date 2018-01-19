#!/bin/bash -e

if [ $AUTH eq "true" ] then 
	printf "$AUTH_USER:$(openssl passwd -crypt $AUTH_PASS)\n" >> /etc/nginx/htpasswd
fi

j2 /nginx.conf.j2 > /etc/nginx/nginx.conf
j2 /nginx-site.conf.j2 > /etc/nginx/conf.d/default.conf
j2 /uwsgi_params > /etc/nginx/conf.d/uwsgi_params
j2 /index.html.j2 > /var/www/localhost/htdocs/index.html
exec "$@"
