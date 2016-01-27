class archivesspace_dev (
  $install_dir = archivesspace_dev::params::install_dir,
  $revision = archivesspace_dev::params::revision,
  $source = archivesspace_dev::params::source,
) inherits archivesspace_dev::params {
  require archivesspace_dev::install
  require archivesspace_dev::bootstrap
  include archivesspace_dev::service
}
