class archivesspace_dev::install 
# (
#$revision = 'master',
#$source = 'https://github.com/NYULibraries/archivesspace.git'
#) 
{
    vcsrepo { '/opt/archivesspace':
      ensure   => present,
      owner    => 'root',
      group    => 'root',
      provider => git,
      require  => Package[ 'git' ],
      source   => $source,
      revision => $revision,
    }

}
