class archivesspace_dev (
  $install_dir     = archivesspace_dev::params::install_dir,
  $revision        = archivesspace_dev::params::revision,
  $source          = archivesspace_dev::params::source,
  $user            = archivesspace_dev::params::user,
  $as_mysql_passwd = archivesspace_dev::params::as_mysql_passwd,
  ) inherits archivesspace_dev::params {
    vcsrepo { $install_dir:
      ensure   => present,
      owner    => $user,
      group    => $user,
      provider => git,
      #require  => Package[ 'git' ],
      source   => $source,
      revision => $revision,
    } 
    remote_file{"${install_dir}/common/lib/mysql-connector-java-5.1.34.jar":
    #remote_file{"/tmp/mysql-connector-java-5.1.34.jar":
      remote_location => 'http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.34/mysql-connector-java-5.1.34.jar',
      require         => Vcsrepo["$install_dir"],
    }
    exec { 'build/run bootstrap' :
      cwd      => $install_dir,
      command  => "${install_dir}/build/run bootstrap",
      timeout  => 1800,
      creates  => "${install_dir}/.devserver_bootstrap_complete",
      notify   => File["${install_dir}/.devserver_bootstrap_complete/" ],
      require  => Vcsrepo["$install_dir"],
    }
    $msg = "    This file is a marker to stop puppet Exec from
    re-running build/run bootstrap. Puppet will not re-run
    build/run bootstrap if this file exists."
    file { "${install_dir}/.devserver_bootstrap_complete":
      ensure  => present,
      content => $msg,
      owner   => $user,
      group   => $user,
    }
    # db_url should be added in place to the config-default.rb file with
    # ini_file.  But that's the next step
    file {"${install_dir}/common/config/config-defaults.rb" :
      ensure  => present,
      owner   => $user,
      group   => $user,
      source  => "puppet:///modules/archivesspace_dev/config-defaults.rb",
      require => Vcsrepo["$install_dir"],
      notify  => Exec['build/run db:migrate'],
    }
    exec { 'build/run db:migrate' :
      cwd      => $install_dir,
      command  => "${install_dir}/build/run db:migrate",
      timeout  => 1800,
      creates  => "${install_dir}/.devserver_db_migrate_complete",
      notify   => File [ "${install_dir}/.devserver_db_migrate_complete" ],
      require  => [Remote_file["${install_dir}/common/lib/mysql-connector-java-5.1.34.jar"], Exec['build/run bootstrap']],
    }
    file { "${install_dir}/.devserver_db_migrate_complete":
      ensure  => present,
      content => "Database migration complete.",
      owner   => $user,
      group   => $user,
    }


}
