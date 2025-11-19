FROM alpine:3.18

# Installer nginx + openssl (pour les certificats)
RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /run/nginx && mkdir -p /etc/nginx/ssl

COPY conf /etc/nginx/conf.d
COPY tools/generate-cert.sh /usr/local/bin/generate-cert.sh

RUN chmod +x /usr/local/bin/generate-cert.sh

# Generation du certificat au moment du build
RUN /usr/local/bin/generate-cert.sh

# Nginx en foreground (PID1 propre)
CMD ["nginx", "-g", "daemon off;"]