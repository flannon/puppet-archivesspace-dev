class archivesspace_devenv::service (
  String $install_dir = lookup('archivesspace_devenv::install_dir', String, 'first'),
  String $user = lookup('archivesspace_devenv::user', String, 'first'),
){

  # Note: the following ports should be opend in in iptables
  # for the archivesspace development envrionment to work,
  #  3000, 3100, 3306, 4567, 8080, 8081, 8089, 8090, 8091

  exec { 'build/run backend:devserver' :
    cwd     => "${install_dir}",
    command => "${install_dir}/build/run  backend:devserver &",
    creates => "${install_dir}/.devserver_backend_started",
    timeout => 1800,
    notify  => File [ "${install_dir}/.devserver_backend_started"],
    require => Vcsrepo["${install_dir}"],
  }

  file { "${install_dir}/.devserver_backend_started":
    ensure  => present,
    content => 'aspace backend devserver started',
    owner   => "${user}",
    group   => "${user}",
  }

  exec { 'build/run frontend:devserver' :
    cwd     => "${install_dir}",
    command => "${install_dir}/build/run  frontend:devserver &",
    creates => "${install_dir}/.devserver_frontend_started",
    timeout => 1800,
    notify  => File [ "${install_dir}/.devserver_frontend_started"],
    require => Vcsrepo["${install_dir}"],
  }

  file { "${install_dir}/.devserver_frontend_started":
    ensure  => present,
    content => 'aspace frontend devserver started',
    owner   => "${user}",
    group   => "${user}",
  }

  exec { 'build/run public:devserver' :
    cwd     => "${install_dir}",
    command => "${install_dir}/build/run  public:devserver &",
    creates => "${install_dir}/.devserver_public_started",
    timeout => 1800,
    notify  => File [ "${install_dir}/.devserver_public_started"],
    require => Vcsrepo["${install_dir}"],
  }

  file { "${install_dir}/.devserver_public_started":
    ensure  => present,
    content => 'aspace public devserver started',
    owner   => "${user}",
    group   => "${user}",
  }

  exec { 'build/run indexer' :
    cwd     => "${install_dir}",
    command => "${install_dir}/build/run  indexer &",
    creates => "${install_dir}/.devserver_indexer_started",
    timeout => 1800,
    notify  => File [ "${install_dir}/.devserver_indexer_started"],
    require => Vcsrepo["${install_dir}"],
  }

  file { "${install_dir}/.devserver_indexer_started":
    ensure  => present,
    content => 'aspace indexer devserver started',
    owner   => "${user}",
    group   => "${user}",
  }


}
