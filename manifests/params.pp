# == Class: sahara::params
#
# Parameters for puppet-sahara
#
class sahara::params {
  $dbmanage_command =
    'sahara-db-manage --config-file /etc/sahara/sahara.conf upgrade head'
  case $::osfamily {
    'RedHat': {
      $package_name = 'openstack-sahara'
      $client_package_name = 'python-saharaclient'
      $service_name = 'openstack-sahara-all'
    }
    'Debian': {
      case $::operatingsystem {
        'Debian': {
          $package_name = 'sahara'
          $client_package_name = 'python-saharaclient'
          $service_name = 'sahara'
        }
        default: {
          fail('While Sahara is packaged in Debian, it is not packaged in \
          Ubuntu or any derivatives (yet).  If you would like to package \
          Sahara for this system, please contact the Sahara team.')
        }
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: \
      ${::operatingsystem}; module ${module_name} does not (yet!) support \
      non-RedHat osfamily")
    }
  }
}
