class archivesspace_dev (
  $install_dir = archivesspace_dev::params::install_dir,
  $revision = archivesspace_dev::params::revision,
  $source = archivesspace_dev::params::source,
  $user = archivesspace_dev::params::user,
  ) inherits archivesspace_dev::params {
  │ #) {
  │ #include archivesspace_dev::install
  │ vcsrepo { $install_dir:
  │ │ ensure   => present,
  │ │ owner    => $user,
  │ │ group    => $user,
  │ │ provider => git,
  │ │ require  => Package[ 'git' ],
  │ │ source   => $source,
  │ │ revision => $revision,
  │ } 

  │ exec { 'build/run bootstrap' :
  │ │ cwd      => "${install_dir}",
  │ │ command  => "${install_dir}/build/run bootstrap",
  │ │ timeout  => 1800,
  │ │ creates  => "${install_dir}/.devserver_bootstrap_has_run",
  │ │ notify   => File [ "${install_dir}/.devserver_bootstrap_has_run/" ],
  │ │ require  => Vcsrepo["${install_dir}"],
  │ }

  │ $msg = "    This file is a marker to stop puppet Exec from
  │ re-running build/run bootstrap. Puppet will not re-run
  │ build/run bootstrap if this file exists."

  │ file { "${install_dir}/.devserver_bootstrap_has_run":
  │ │ ensure  => present,
  │ │ content => $msg,
  │ │ owner   => $user,
  │ │ group   => $user,
  │ }

}
