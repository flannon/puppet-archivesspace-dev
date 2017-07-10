class archivesspace_devenv (
  String $install_dir = archivesspace_devenv::install_dir),
  String $revision = archivesspace_devenv::revision),
  String $source = archivesspace_devenv::source),
  String $user = archivesspace_devenv::user),
) {
    #) {
    #include archivesspace_devenv::install
    class { 'archivesspace_devenv::install' :
      revision => $revision,
      source   => 'https://github.com/NYULibraries/archivesspace.git',
    }
    include archivesspace_devenv::bootstrap
    include archivesspace_devenv::service
    Class['archivesspace_devenv::install'] -> Class ['archivesspace_devenv::bootstrap'] -> Class['archivesspace_devenv::service']

}
