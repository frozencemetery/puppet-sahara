# == Class: sahara::params
#
# Parameters for puppet-sahara
#
class sahara::params {
  case $::osfamily {
    'RedHat': {
      $package_name =        'openstack-sahara'
      $client_package_name = 'python-saharaclient'
      $service_name =        'openstack-sahara-all'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: \
      ${::operatingsystem}; module ${module_name} does not (yet!) support \
      non-RedHat osfamily")
    }
  }
}
