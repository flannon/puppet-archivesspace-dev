class archivesspace_devenv::bootstrap (
 String $install_dir = lookup(archivesspace_devenv::install_dir, String, 'first'),
 String $user        = lookup(archivesspace_devenv::user, String, 'first'),
) {

    ##  Need to assemble the config file and attach it to the
    #   mysql database at this point.
    #

    #file { '/opt/archivesspace/common/config/config.rb' :
    #  ensure => present,
    #  source => 'puppet://modules/archivesspace/dev-config.rb',
    #  mode   => '0644',
    #  notify => Exec['build/run'],
    #}

    exec { 'build/run bootstrap' :
      cwd      => "${install_dir}",
      command  => "${install_dir}/build/run bootstrap",
      timeout  => 1800,
      creates  => "${install_dir}/.devserver_bootstrap_has_run",
      notify   => File["${install_dir}/.devserver_bootstrap_has_run/"],
      require  => Vcsrepo["${install_dir}"],
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
