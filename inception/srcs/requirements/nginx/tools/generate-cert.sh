# Generation du certificat auto-signe pour HTTPS
openssl req -x509 -nodes -days 365 \
    -subj "/C=FR/ST=Paris/O=42/OU=Inception/CN=${DOMAIN_NAME}" \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt