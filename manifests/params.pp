class archivesspace_dev::params {
  $install_dir = '/opt/archivesspace'
  $revision    = 'master'
  $source      = 'https://github.com/NYULibraries/archivesspace.git'
  #$as_mysql_passwd = 'aspace'
  $mysql_asdb_passwd = hiera('archivesspace_dev::mysql_asdb_passwd')

  case $::osfamily {
    'RedHat': {
      $user = $id
    }
    'Darwin': {
      $user = $sp_user_name
    }
    default: {
      fail ("osfamily ${::osfamily} is not supported by this module")
    }
  }
}
