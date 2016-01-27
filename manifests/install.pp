class archivesspace_dev::install 
# (
#$revision = 'master',
#$source = 'https://github.com/NYULibraries/archivesspace.git'
#) 
{
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
