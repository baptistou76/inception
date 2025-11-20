#!/bin/bash
# Démarrer le service MariaDB
service mariadb start;

# Créer la base de données si elle n'existe pas
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

# Créer l'utilisateur s'il n'existe pas
mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"

# Accorder tous les privilèges à l'utilisateur sur la base de données
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

# Changer le mot de passe du root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

# Reactualisation des privilèges
mysql -e "FLUSH PRIVILEGES;"

# Arrêter proprement MariaDB
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# Lancer MariaDB en mode sécurisé
exec mysqld_safe

# Message de succès
echo "MariaDB database and user were created successfully!"
