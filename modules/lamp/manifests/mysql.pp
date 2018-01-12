define lamp::mysql (
  $db_user,
  $db_password,
  $host     = $::hostname,
  $database = $name,
) {

  class { 'mysql::server':
    override_options => {
      'mysqld' => { 'bind-address' => '0.0.0.0' }
    },
  }

  service { 'firewalld':
    ensure => stopped,
  }

  mysql::db { $database:
    user     => $db_user,
    password => $db_password,
    host     => '%',
    grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
  }

  class { '::mysql::bindings':
    php_enable       => true,
  }

}
