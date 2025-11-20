# Generation du certificat auto-signe pour HTTPS
openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=NORMANDIE/L=LE_HAVRE/O=42/OU=42/CN=${DOMAIN_NAME}" \
    -addext "subjectAltName=DNS:${DOMAIN_NAME}"