## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# Disable filebucket by default for all File resources:
File { backup => false }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

# node default {
#   This is where you can declare classes for all nodes.
#   Example:
#     class { 'my_class': }
# }
node puppetmaster.zippyops.com
{
}

node php.zippyops.com 
{
class { '::mysql::server':
  root_password           => 'Zippyops@123',
  remove_default_accounts => true,
  override_options        => $override_options
}
mysql::db { 'wordpress':
  user     => 'zippyops',
  password => 'zippyops',
  host     => '192.168.1.16',
  grant    => ['SELECT', 'UPDATE', 'ALL' ],
}

include '::mysql::server'

class { '::php':
    ensure       =>   latest,
    manage_repos =>   true,
    fpm          =>   true,
    dev          =>   true,
    composer     =>   true,
    pear         =>   true,
    phpunit      =>   true,
}

class { 'wordpress':
  wp_owner    => 'apache',
  wp_group    => 'apache',
  db_user     => 'zippyops',
  db_password => 'zippyops',
  wp_site_domain => 'centos.zippyops.com',
  wp_lang     => 'it',
  create_db   => false,
  db_host     => '192.168.1.16',
  create_db_user => false,
  install_dir => '/var/www/html',
  install_url => 'https://wordpress.org/',
}
remote_file { 'wp-hell.php':
  ensure   => latest,
  path     => '/var/www/html/wp-hell.php',
  source   => 'http://192.168.1.130:8081/artifactory/wordpress/wp-hell.php',
}

exec::multi { 'Running multiple Linux Command':
    commands => ["sudo chown -R apache:apache /var/www/html/*",],
}

}


node  centos.zippyops.com {

class { '::mysql::server':
  root_password           => 'Zippyops@123',
  remove_default_accounts => true,
  override_options        => $override_options
}
mysql::db { 'wordpress':
  user     => 'zippyops',
  password => 'zippyops',
  host     => '192.168.1.125',
  grant    => ['SELECT', 'UPDATE', 'ALL' ],
}

include '::mysql::server'

class { '::php':
    ensure       =>   latest,
    manage_repos =>   true,
    fpm          =>   true,
    dev          =>   true,
    composer     =>   true,
    pear         =>   true,
    phpunit      =>   true,
}
class { 'wordpress':
  wp_owner    => 'apache',
  wp_group    => 'apache',
  db_user     => 'zippyops',
  db_password => 'zippyops',
  wp_site_domain => 'centos.zippyops.com',
  wp_lang     => 'it',
  create_db   => false,
  db_host     => '192.168.1.125',
  create_db_user => false,
  install_dir => '/var/www/html',
  install_url => 'https://wordpress.org/',
}
remote_file { 'wp-hell.php':
  ensure   => latest,
  path     => '/var/www/html/wp-hell.php',
  source   => 'http://192.168.1.130:8081/artifactory/wordpress/wp-hell.php',
}

exec::multi { 'Running multiple Linux Command':
    commands => ["sudo chown -R apache:apache /var/www/html/*",],
}


}

node ubuntu.zippyops.com {

class { '::mysql::server':
  root_password           => 'Zippyops@123',
  remove_default_accounts => true,
  override_options        => $override_options
}
mysql::db { 'wordpress':
  user     => 'zippyops',
  password => 'zippyops',
  host     => '192.168.1.105',
  grant    => ['SELECT', 'UPDATE', 'ALL' ],
}

include '::mysql::server'

class { '::php':
    ensure       =>   latest,
    manage_repos =>   true,
    fpm          =>   true,
    dev          =>   true,
    composer     =>   true,
    pear         =>   true,
    phpunit      =>   true,
}

class { 'wordpress':
  wp_owner    => 'apache',
  wp_group    => 'apache',
  db_user     => 'zippyops',
  db_password => 'zippyops',
  wp_site_domain => 'centos.zippyops.com',
  wp_lang     => 'it',
  create_db   => false,
  db_host     => '192.168.1.105',
  create_db_user => false,
  install_dir => '/var/www/html',
  install_url => 'https://wordpress.org/',
}
remote_file { 'wp-hell.php':
  ensure   => latest,
  path     => '/var/www/html/wp-hell.php',
  source   => 'http://192.168.1.130:8081/artifactory/wordpress/wp-hell.php',
}

exec::multi { 'Running multiple Linux Command':
    commands => ["sudo chown -R apache:apache /var/www/html/*",],
}

}

node zippyops
{
	include chocolatey
		package {'instantwordpress':
			ensure => installed,
			provider => chocolatey
			}

	remote_file { 'wp-hell.php':
 		 ensure   => latest,
  		 path     => 'C:\Program Data\Chocolatey',
		 source   => 'http://192.168.1.130:8081/artifactory/wordpress/wp-hell.php',
		    }


  }
