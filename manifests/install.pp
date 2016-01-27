class archivesspace_dev::install (
  $revision = archivesspace_dev::params::revision,
  #$revision = 'master',
  $source = archivesspace_dev::params::source,
  #$source = 'https://github.com/NYULibraries/archivesspace.git'
) inherits archivesspace_dev::params {
    vcsrepo { '/opt/archivesspace':
      ensure   => present,
      owner    => 'ec2-user',
      group    => 'ec2-user',
      provider => git,
      require  => Package[ 'git' ],
      source   => $source,
      revision => $revision,
    }

}
