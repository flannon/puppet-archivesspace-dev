class archivesspace_devenv::install (
  String $install_dir = lookup($archivesspace_devenv::install_dir),
  String $revision    = lookup($archivesspace_devenv::revision),
  String $source      = lookup($archivesspace_devenv::source),
  String $user        = lookup($archivesspace_devenv::user),
  ) inherits archivesspace_devenv::params {
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
