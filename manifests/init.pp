# == Class: sahara
#
#  Sahara base package & configuration
#
# === Parameters
#
# [*package_ensure*]
#   (Optional) Ensure state for package
#   Defaults to 'present'
#
# [*verbose*]
#   (Optional) Should the daemons log verbose messages
#   Defaults to 'false'
#
# [*debug*]
#   (Optional) Should the daemons log debug messages
#   Defaults to 'false'
#
# [*service_host*]
#   (Optional) Hostname for sahara to listen on
#   Defaults to '127.0.0.1'
#
# [*service_port*]
#   (Optional) Port for sahara to listen on
#   Defaults to 8386
#
# [*use_neutron*]
#   (Optional) Whether to use neutron
#   Defaults to true
#
# [*database_connection*]
#   (Optional) Non-sqllite database for sahara
#   Defaults to mysql://sahara:secrete@localhost:3306/sahara
#
# == keystone authentication options
#
# [*os_username*]
#   (Optional) Username for sahara credentials
#   Defaults to 'admin'
#
# [*os_password*]
#   (Optional) Password for sahara credentials
#   Defaults to 'secrete'
#
# [*os_tenant_name*]
#   (Optional) Tenant for os_username
#   Defaults to 'admin'
#
# [*os_auth_url*]
#   (Optional) Public identity endpoint
#   Defaults to 'http://127.0.0.1:5000/v2.0/'
#
# [*identity_url*]
#   (Optional) Admin identity endpoint
#   Defaults to 'http://127.0.0.1:35357/'
#

class sahara(
  $package_ensure =      'present',
  $verbose =             false,
  $debug =               false,
  $service_host =        '127.0.0.1',
  $service_port =        8386,
  $use_neutron =         true,
  $database_connection = 'mysql://sahara:secrete@localhost:3306/sahara',
  $os_username =         'admin',
  $os_password =         'secrete',
  $os_tenant_name =      'admin',
  $os_auth_url =         'http://127.0.0.1:5000/v2.0/',
  $identity_url =        'http://127.0.0.1:35357/',
) {
  include sahara::params

  file { '/etc/sahara/':
    ensure => directory,
    owner => 'root',
    group => 'sahara',
    mode => '0750',
    require => Package['sahara'],
  }

  file { '/etc/sahara/sahara.conf':
    owner => 'root',
    group => 'sahara',
    mode => '0640',
    require => File['/etc/sahara'],
  }
  
  package { 'sahara':
    ensure => $package_ensure,
    name => $::sahra::params::package_name,
  }
  package { 'saharaclient':
    ensure => $package_ensure,
    name => $::sahara::params::client_package_name,
    require => Package['sahara'],
  }

  Package['sahara'] -> Sahara_config<||>

  sahara_config {
    'DEFAULT/use_neutron': value => $use_neutron;
    'DEFAULT/host': value => $service_host;
    'DEFAULT/port': value => $service_port;
    'DEFAULT/debug': value => $debug;
    'DEFAULT/verbose': value => $verbose;
    
    'database/connection': value => $database_connection;

    'keystone_authtoken/auth_uri': value => $os_auth_url;
    'keystone_authtoken/identity_uri': value => $identity_url;
    'keystone_authtoken/admin_user': value => $os_username;
    'keystone_authtoken/admin_tenant_name': value => $os_tenant_name;
    'keystone_authtoken/admin_password':
      value => $os_password,
      secret => true;
  }
}
