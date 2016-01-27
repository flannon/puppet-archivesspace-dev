class archivesspace_dev::service {

  # Note: the following ports should be opend in in iptables
  # for the archivesspace development envrionment to work,
  #  3000, 3100, 3306, 4567, 8080, 8081, 8089, 8090, 8091

  exec { 'build/run backend:devserver' :
    cwd      => '/opt/archivesspace',
    command  => '/opt/archivesspace/build/run  backend:devserver',
    #creates   => "${install_dir}/.devserver_backend_started",
    unless   => "/usr/bin/test -f ${::install_dir}/.devserver_backend_started",
    timeout  => 1800,
    #before   => File["${install_dir}/.devserver_backend_started"],
  }

  file { "${::install_dir}/.devserver_backend_started]":
    ensure  => present,
    content => 'aspace backend devserver started',
    require => Exec['build/run backend:devserver'],
  }

  exec { 'build/run frontend:devserver' :
    command  => '/opt/archivesspace/build/run  frontend:devserver',
    cwd      => '/opt/archivesspace',
    #creates   => "${install_dir}/.devserver_frontend_started",
    unless   => "/usr/bin/test -f ${::install_dir}/.devserver_frontend_started",
    timeout  => 1800,
    #before   => File["${install_dir}/.devserver_frontend_started"],
  }

  file { "${::install_dir}/._devserver_frontend_started]":
    ensure  => present,
    content => 'aspace frontend devserver started',
    require => Exec['build/run frontend:devserver'],
  }

  exec { 'build/run public:devserver' :
    command  => '/opt/archivesspace/build/run  public:devserver',
    cwd      => '/opt/archivesspace',
    #creates   => "${install_dir}/.devserver_public_started]",
    unless   => "/usr/bin/test -f ${::install_dir}/.devserver_public_started]",
    timeout  => 1800,
    #before   => File["${install_dir}/.devserver_public_started"],
  }

  file { "${::install_dir}/._devserver_public_started]":
    ensure  => present,
    content => 'aspace public devserver started',
    require => Exec['build/run public:devserver'],
  }

  exec { 'build/run indexer' :
    command  => '/opt/archivesspace/build/run  indexer',
    cwd      => '/opt/archivesspace',
    #creates   => "${install_dir}/.devserver_indexer_started]",
    unless   => "/usr/bin/test -f ${::install_dir}/.devserver_indexer_started]",
    timeout  => 1800,
    #before   => File["${install_dir}/.devserver_indexer_started"],
  }

  file { "${::install_dir}/._devserver_indexer_started]":
    ensure  => present,
    content => 'aspace indexer devserver started',
    require => Exec['build/run indexer'],
  }

}
