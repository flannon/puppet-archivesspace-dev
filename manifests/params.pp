class archivesspace_dev::params {
  $install_dir = '/opt/archivesspace'
  $revision    = 'master'
  $source      = 'https://github.com/NYULibraries/archivesspace.git'

  case $::osfamily {
    'redhat': {
      $user = 'ec2-user'
    }
    default: {
      fail ("osfamily ${::osfamily} is not supported by this module")
    }
  }
}
