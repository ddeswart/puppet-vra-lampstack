class profile::db (
  $db_username = 'test',
  $db_password = 'test',
  $dbname = 'foo'
) {

  class { 'mysql::server':
    remove_default_accounts => true
  }

  @@mysqldb { $dbname:
    user     => $db_username,
    database => $dbname, 
    password => $db_password,
    host     => $::fqdn,
  }

  mysql::db { $dbname:
    user     => $db_username,
    password => $db_password,
    host     => $::fqdn,
    grant    => ['ALL'],
  }

}
