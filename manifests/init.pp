class archivesspace_devenv (
  String $install_dir = archivesspace_dev::install_dir),
  String $revision = archivesspace_dev::revision),
  String $source = archivesspace_dev::source),
  String $user = archivesspace_dev::user),
) {
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
