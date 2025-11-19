# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user <user@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/19 10:08:23 by user              #+#    #+#              #
#    Updated: 2025/11/19 10:08:24 by user             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.18

# Installer PHP et les extensions requises par WP
RUN apk update && apk add --no-cache \
    php8 \
    php8-fpm \
    php8-mysqli \
    php8-pdo \
    php8-pdo_mysql \
    php8-json \
    php8-openssl \
    php8-curl \
    php8-dom \
    php8-exif \
    php8-fileinfo \
    php8-zip \
    php8-mbstring \
    php8-gd \
    php8-session \
    php8-tokenizer \
    php8-xml \
    curl \
    mariadb-client

# Installer tini pour gererle pid1 etles signaux
RUN apk add --no-cache tini

RUN adduser -D -g 'www' www

# Creation du repertoire pour WP
RUN mkdir -p /var/www/html && chown -R www:www /var/www/html

WORKDIR /var/www/html

# Copie des scripts d'installation
COPY tools/install.sh /tmp/install.sh
COPY tools/wp-config-template.php /tmp/wp-config-template.php

RUN chmod +x /tmp/install.sh

USER www

# Demarrage via tini, puis php-fpm en foreground
ENTRYPOINT [ "/sbin/tini", "--" ]

CMD [ "php-fpm8", "-F" ]