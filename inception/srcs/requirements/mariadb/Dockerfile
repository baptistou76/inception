# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user <user@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/19 10:08:54 by user              #+#    #+#              #
#    Updated: 2025/11/19 10:10:20 by user             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:12

# Mise a jour et installation de mariadb
RUN apt-get update && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/*

# Creation du dossier qui contiendra le script d'init
RUN mkdir -p /docker-entrypoint-initdb.d

# Copie des fichiers SQL
# mariadb va utiliser les fichiers sql uniquement au premier demarrage si le volume n'existe pas
COPY docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/

# Copie de la config de mariadb
COPY conf/my.cnf /etc/mysql/my.cnf

# Expose le port interne de mariadb
EXPOSE 3306

# mariadb doit tourner en "foreground"
CMD [ "mysqld" ]