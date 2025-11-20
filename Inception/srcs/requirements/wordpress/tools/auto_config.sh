sleep 10

cd /var/www/html/wordpress

	echo "CREATING CONFIG ... \n"
	wp config create --allow-root \
	--dbname=${MYSQL_DATABASE} \
    --dbuser=${MYSQL_USER} \
    --dbpass=${MYSQL_PASSWORD} \
    --dbhost=mariadb \
    --path='/var/www/html/wordpress' \
    --url=https://${DOMAIN_NAME}

	wp core install --allow-root \
        --path='/var/www/html/wordpress' \
        --url=https://${DOMAIN_NAME} \
        --title=${SITE_TITLE} \
        --admin_user=${ADMIN_USER} \
        --admin_password=${ADMIN_PASSWORD} \
        --admin_email=${ADMIN_EMAIL}

	wp user create --allow-root \
        ${SECOND_USER} ${SECOND_USER_EMAIL} \
        --role=author \
        --user_pass=${SECOND_USER_PASSWORD}

	wp cache flush --allow-root

	echo "wp-config created successfully !"

if [ ! -d /run/php ]; then
	mkdir /run/php
fi

exec /usr/sbin/php-fpm -F -R