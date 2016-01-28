class archivesspace_dev::params {
  $install_dir = '/opt/archivesspace'
  $revision    = 'master'
  $source      = 'https://github.com/NYULibraries/archivesspace.git'

  case $::osfamily {
    'RedHat': {
      $user = 'ec2-user'
    }
    'Darwin': {
      $user = $sp_user_name
    }
    default: {
      fail ("osfamily ${::osfamily} is not supported by this module")
    }
  }
}
