class { 'mysql::server':
  root_password => 'Zippyops@123'
}
mysql::db { 'wordpress':
  user     => 'zippyops',
  password => 'zippyops',
  host     => 'localhost',
  grant    => ['SELECT', 'UPDATE','ALL'],
}
mysql::db { "mydb_${fqdn}":
  user     => 'myuser',
  password => 'mypass',
  dbname   => 'mydb',
  host     => $::fqdn,
  grant    => ['SELECT', 'UPDATE'],
  tag      => $domain,
}
