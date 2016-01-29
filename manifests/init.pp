class archivesspace_dev (
  $install_dir = archivesspace_dev::params::install_dir,
  $revision = archivesspace_dev::params::revision,
  #$revision = 'master',
  $source = archivesspace_dev::params::source,
  #$source = 'https://github.com/NYULibraries/archivesspace.git'
  $user = archivesspace_dev::params::user,
  ) inherits archivesspace_dev::params {
    #) {
    #anchor { 'archivesspace_dev::begin': } ->
    #include archivesspace_dev::install  
    class { 'archivesspace_dev::install' :
      revision => 'v1.4.2',
      source   => 'https://github.com/NYULibraries/archivesspace.git',
    }
    #include archivesspace_dev::bootstrap
    #include archivesspace_dev::service
    #anchore { 'archivesspace_dev::end': }
    #Class['archivesspace_dev::install'] -> Class ['archivesspace_dev::bootstrap']

}
