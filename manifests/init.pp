class archivesspace_dev (
  $install_dir = archivesspace_dev::params::install_dir,
  $revision = archivesspace_dev::params::revision,
  $source = archivesspace_dev::params::source,
  $user = archivesspace_dev::params::user,
  ) inherits archivesspace_dev::params {
    #) {
    #include archivesspace_dev::install
    class { 'archivesspace_dev::install' :
      revision => 'master',
      source   => 'https://github.com/NYULibraries/archivesspace.git',
    }
    include archivesspace_dev::bootstrap
    include archivesspace_dev::service
    Class['archivesspace_dev::install'] -> Class ['archivesspace_dev::bootstrap'] -> Class['archivesspace_dev::service']

}
