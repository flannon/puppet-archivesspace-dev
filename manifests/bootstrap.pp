class archivesspace_dev::bootstrap (
 $install_dir = $archivesspace_dev::params::install_dir,
 $user        = $archivesspace_dev::params::user
) inherits archivesspace_dev::params {

   #file { '/opt/archivesspace/common/config/config.rb' :
   #   ensure => present,
   #   source => 'puppet://modules/archivesspace/config.rb',
   #   mode   => '0644',
   #}

    exec { 'build/run bootstrap' :
      cwd      => "${install_dir}",
      command  => "${install_dir}/build/run bootstrap",
      timeout  => 1800,
      creates  => "${install_dir}/.devserver_bootstrap_has_run",
      notify   => File [ "${install_dir}/.devserver_bootstrap_has_run/" ],
      require  => [ Vcsrepo["${install_dir}"], Exec['build/run bootstrap'] ],
    }

    $msg = "    This file is a marker to stop puppet Exec from
    re-running build/run bootstrap. Puppet will not re-run
    build/run bootstrap if this file exists."

    file { "${install_dir}/.devserver_bootstrap_has_run":
      ensure  => present,
      content => $msg,
      owner   => $user,
      group   => $user,
    }

}
