#!/bin/ash -e

mkdir -p /run/nginx/
rm -rf /run/nginx/nginx.pid

if [ ${#} -eq 0 ]; then
  echo "Starting docker-nginx"

  j2 --undefined /code/templates/nginx.conf.j2 > /etc/nginx/nginx.conf
  j2 --undefined /code/templates/site.conf.j2 > /etc/nginx/conf.d/site.conf

  if [ "${UWSGI}" == "true" ]; then
    cp /code/conf/uwsgi_params /etc/nginx/uwsgi_params
  fi

  if [ "${MAINTENANCE}" == "true" ]; then
    cp -vr /code/html /var/www/
  fi

  if [ ! -z ${BASIC_AUTH_ALL} ] || [ ! -z ${BASIC_AUTH_LOCATIONS} ]; then
    if [ ! -z ${BASIC_AUTH_USER} ] && [ ! -z ${AWS_SM_PATH} ] && [ -z ${BASIC_AUTH_PASS} ]; then
      BASIC_AUTH_PASS=$(aws_sm --path "${AWS_SM_PATH}" --key "${AWS_SM_KEY:-BASIC_AUTH_PASS}")
    elif [ -z ${BASIC_AUTH_USER} ] || [ -z ${BASIC_AUTH_PASS} ]; then
      echo "Missing basic auth credentials."
      echo "Set BASIC_AUTH_USER and BASIC_AUTH_PASS or BASIC_AUTH_USER and AWS_SM_PATH, AWS_DEFAULT_REGION (and optionally AWS_SM_KEY)."
      exit 2
    fi
    echo "${BASIC_AUTH_USER}:$(openssl passwd -crypt ${BASIC_AUTH_PASS})" > /etc/nginx/htpasswd
  fi

  if [[ "${DEV_SSL_CERT}" == "true" ]]; then
    cp -rp /code/certs /etc/nginx
  fi

  if [[ "${DEBUG}" == "true" ]]; then
    for i in /etc/nginx/nginx.conf $(ls -d /etc/nginx/conf.d/*); do
      printf "\n# ${i}:"
      cat ${i}
    done
  fi
  echo "Starting nginx"
  exec nginx -g 'daemon off;'
else
  exec "${@}"
fi
