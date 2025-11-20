FROM debian:bullseye

# Mettre a jour les paquets
RUN apt-get update -y

# Installer les MAJ
RUN apt-get install -y wget

# Installer PHP8.2
RUN apt-get install -y \
	php82 \
	php82-fpm \
	php82-mysqli \
    php82-pdo_mysql \
    php82-json \
    php82-openssl \
    php82-curl \
    php82-zip \
    php82-mbstring \
    php82-gd \
    php82-xml \
    curl \
    mariadb-client

# Installer WP-CLI pour la gestion de wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Installer le client MySQL par defaut
RUN apt-get update && apt-get install -y default-mysql-client

# Installer le client mariadb
RUN apt-get install -y mariadb-client

# Telecharger WordPress dans le repertoire html
RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html

# Extraire wordpress et supprimer le fichier compresse
RUN cd /var/www/html && \
    tar -xzf /var/www/html/wordpress-6.1.1.tar.gz && \
    rm /var/www/html/wordpress-6.1.1.tar.gz

# Changer les permissions pour le repertoire /var/www
RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 755 /var/www/*

# Expose le port 9000 pour PHP
EXPOSE 9000

# Copier le script d'auto_config dans l'image
COPY ./tools/auto_config.sh .

# Rend le script executable
RUN chmod +x ./auto_config.sh

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Definir le point d'entree pour lancer le script d'auto_config
ENTRYPOINT ["./auto_config.sh"]