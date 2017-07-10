class archivesspace_devenv::install (
  String $install_dir = lookup($archivesspace_dev::install_dir),
  String $revision    = lookup($archivesspace_dev::revision),
  String $source      = lookup($archivesspace_dev::source),
  String $user        = lookup($archivesspace_dev::user),
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
