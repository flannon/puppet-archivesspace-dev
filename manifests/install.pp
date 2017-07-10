class archivesspace_devenv::install (
  String $install_dir = lookup('archivesspace_devenv::install_dir', String, 'first'),
  String $revision    = lookup('archivesspace_devenv::revision', String, 'first'),
  String $source      = lookup('archivesspace_devenv::source', String, 'first'),
  String $user        = lookup('archivesspace_devenv::user', String, 'first'),
){
    vcsrepo { $install_dir:
      ensure   => present,
      owner    => $user,
      group    => $user,
      provider => git,
      require  => Package[ 'git' ],
      source   => $source,
      revision => $revision,
    }

}
