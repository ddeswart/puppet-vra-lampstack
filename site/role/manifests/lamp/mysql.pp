class role::lamp::mysql {

  include profile::linux_baseline
  include profile::vro_provisioned
  include profile::lamp::mysql

}
