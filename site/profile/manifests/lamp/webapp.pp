class profile::lamp::webapp {

  $requestid     = $facts['puppet_vra_properties']['RequestId']
  $query         = "resources { type = 'Lamp::Mysql' and title = \"${requestid}\" }"
  $db_connection = puppetdb_query($query)

  lamp::webapp { $requestid:
    db_user     => $db_connection[0]['parameters']['db_user'],
    db_password => $db_connection[0]['parameters']['db_password'],
    db_host     => $db_connection[0]['parameters']['host'],
    db_name     => $db_connection[0]['parameters']['database'],
  }

}
