class profile::lamp::mysql (
  $db_user     = $facts['puppet_vra_properties']['lamp_db_user'],
  $db_password = $facts['puppet_vra_properties']['lamp_db_password'],
  $host        = $::fqdn,
  $database    = $facts['puppet_vra_properties']['lamp_db_name']
  ) {

  $requestid = $facts['puppet_vra_properties']['RequestId']

  lamp::mysql { $requestid:
    db_user     => $db_user,
    db_password => $db_password,
    host        => $host,
    database    => $database,
  }

}
