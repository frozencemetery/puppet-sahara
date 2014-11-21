# == Class: sahara::client
#
# Installs the sahara python library.
#
# === Parameters
#
# [*ensure*]
#   (Optional) Ensure state for package.
#
class sahara::client (
  $ensure = 'present'
) {
  include sahara::params

  package { 'saharaclient':
    ensure => $package_ensure,
    name => $::sahara::params::client_package_name,  
  }
}
