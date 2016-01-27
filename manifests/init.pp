class archivesspace_dev (
  $install_dir = archivesspace_dev::params::install_dir,
  $revision = archivesspace_dev::params::revision,
  $source = archivesspace_dev::params::source,
) inherits archivesspace_dev::params {
  require archivesspace::dev-install
  require archivesspace::dev-bootstrap
}
