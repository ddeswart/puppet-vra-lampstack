define lamp::webapp (
  $db_user,
  $db_password,
  $db_host,
  $db_name,
  $docroot = '/var/www/html'
) {

  class { 'apache':
    default_mods  => false,
    mpm_module    => 'prefork',
    default_vhost => false,
  }

  service { 'firewalld':
    ensure => stopped,
  }

  exec { 'ensure SELinux is not blocking httpd network access':
    command => 'setsebool -P httpd_can_network_connect=1',
    onlyif  => 'getsebool httpd_can_network_connect | grep off',
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin:/root/bin',
  }

  apache::vhost { $name:
    port           => '80',
    docroot        => $docroot,
    directoryindex => ['index.php','index.html'],
  }

  package { 'php':
    ensure => installed,
    notify => Service['httpd'],
  }

  package { 'php-mysql':
    ensure => installed,
    notify => Service['httpd'],
  }

  include apache::mod::php

  $indexphp = @("EOT"/)
    <?php
    \$conn = mysql_connect('${db_host}', '${db_user}', '${db_password}');
    if (!\$conn) {
      echo '<h1>Connection to ${db_host} as ${db_user} failed</h1>';
    } else {
      echo '<h1>Connected successfully to ${db_host} as ${db_user}';
    }
    ?>
    | EOT

  file { "${docroot}/index.php":
    ensure  => file,
    content => $indexphp,
  }

  file { "${docroot}/index.html":
    ensure  => file,
    content => "<meta http-equiv=\"refresh\" content=\"1;url=http://$::ipaddress/index.php\">",
  }

}
