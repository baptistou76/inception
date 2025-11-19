# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user <user@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/19 10:07:55 by user              #+#    #+#              #
#    Updated: 2025/11/19 11:51:57 by user             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

set -e

WP_PATH="/var/www/html"

# Si Wordpress est deja installe, on ne fait rien
if [ -f "$WP_PATH/wp-config.php" ]; then
    echo "Wordpress already configured, normaly started"
    exit 0

fi

echo "Telechargement de wordpress..."
curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
tar -xzf /tmp/wordppress.tar.gz -C /tmp
cp -r /tmp/wordpress/* $WP_PATH

echo "wp-config.php file created from template..."

# Lecture des secrets
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# Copier le template
cp /tmp/wp-config-template.php $WP_PATH/wp-config.php

# Remplacement des valeurs dans wp-config.php
sed -i "s|__DB_NAME__|$MYSQL_DATABASE|g" $WP_PATH/wp-config.php
sed -i "s|__DB_USER__|$MYSQL_USER|g" $WP_PATH/wp-config.php
sed -i "s|__DB_PASSWORD__|$DB_PASSWORD|g" $WP_PATH/wp-config.php
sed -i "s|__DB_HOST__|$WORDPRESS_DB_HOST|g" $WP_PATH/wp-config.php

echo "WP-CLI configuration..."

# Installation WP-CLI  si pas installe
if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

cd $WP_PATH

echo "Waiting from mariadb..."

# Boucle d'attente simple (autorisee car elle a une fin)
until mysql -h $WORDPRESS_DB_HOST -u $MYSQL_USER -p"DB_PASSWORD" -e "SELECT 1;" >/dev/null 2>&1; do
    echo "mariadb not already yet..."
    sleep 1
done

echo "Installation of wordpress from WP_CLI..."

wp core install \
    --url="$DOMAIN_NAME" \
    --title="Inception project" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$(cat /run/secrets/wp_admin_password)" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --skip-email

echo "Wordpress's installation is finished !!!"