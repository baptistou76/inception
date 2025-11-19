/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   wp-config-template.php                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: user <user@student.42.fr>                  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/19 10:08:18 by user              #+#    #+#             */
/*   Updated: 2025/11/19 12:16:12 by user             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

<!-- Toutes les valeurs sont remplacees par install.sh -->
define( 'DB_NAME', '__DB_NAME__' );
define('DB_USER', '__DB_USER__');
define('DB_PASSWORD', '__DB_PASSWORD__');
define('DB_HOST', '__DB_HOST__');

define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

<!-- Cles et sels d'authentification -->
<!-- Securisees automatiquement pendant l'installation -->
define('AUTH_KEY', 'generate during wp install');
define('SECURE_AUTH_KEY', 'generate during wp install');
define('LOGGED_IN_KEY', 'generate during wp install');
define('NONCE_KEY', 'generate during wp install');
define('AUTH_SALT', 'generate during wp install');
define('SECURE_AUTH_SALT', 'generate during wp install');
define('LOGGED_IN_SALT', 'generate during wp install');
define('NONCE_SALT', 'generate during wp install');

$table_prefix = 'wp_';

define('WP_DEBUG', false);

<!-- Chemin vers Wordpress -->
if (!defined('ABSPATH'))
        define('ABSPATH', dirname(__FILE__) . '/');

require_once ABSPATH . 'wp-settings.php';