class archivesspace_dev::install (
  $install_dir = $archivesspace_dev::params::install_dir,
  $revision    = $archivesspace_dev::params::revision,
  $source      = $archivesspace_dev::params::source,
  $user        = $archivesspace_dev::params::user
  ) inherits archivesspace_dev::params {
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
