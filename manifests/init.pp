class archivesspace_devenv (
  String $install_dir = lookup('archivesspace_devenv::install_dir', String, 'first'),
  String $revision = lookup('archivesspace_devenv::revision', String, 'first'),
  String $source = lookup('archivesspace_devenv::source', String, 'first'),
  String $user = lookup('archivesspace_devenv::user', String, 'first'),
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
