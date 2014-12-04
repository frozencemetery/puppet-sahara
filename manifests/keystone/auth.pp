# == Class: sahara::keystone::auth
#
# Configures sahara service and endpoint in Keystone.
#
# === Parameters
# [*service_name*]
#   (Optional) Name of the service.
#   Defaults to the value of auth_name.
#
# [*auth_name*]
#   (Optional) Username for sahara service.
#   Defaults to 'sahara'.
#
# [*service_type*]
#   (Optional) Type of service.
#   Defaults to 'data_processing'.
#
# [*service_description*]
#   (Optional) Description of service.
#   Defaults to 'Sahara Data Processing'.
#
# [*region*]
#   (Optional) Region for endpoint.
#   Defaults to 'RegionOne'.
#
# [*public_protocol*]
#   (Optional) Protocol for public endpoint.
#   Defaults to 'http'.
#
# [*admin_protocol*]
#   (Optional) Protocol for admin endpoint.
#   Defaults to 'http'.
#
# [*internal_protocol*]
#   (Optional) Protocol for internal endpoint.
#   Defaults to 'http'.
#
# [*public_address*]
#   (Optional) Public address for endpoint.
#   Defaults to '127.0.0.1'.
#
# [*admin_address*]
#   (Optional) Admin address for endpoint.
#   Defaults to '127.0.0.1'.
#
# [*internal_address*]
#   (Optional) Internal address for endpoint.
#   Defaults to '127.0.0.1'.
#
# [*port*]
#   (Optional) Port for endpoint.
#   Defaults to '8386'.
#
# [*version*]
#   (Optional) Version of API to use.
#   Defaults to 'v1.1'.
#
class sahara::keystone::auth(
  $service_name = undef,
  $auth_name = 'sahara',
  $service_type = 'data_processing',
  $service_description = 'Sahara Data Processing',
  $region = 'RegionOne',
  $public_protocol = 'http',
  $admin_protocol = 'http',
  $internal_protocol = 'http',
  $public_address = '127.0.0.1',
  $admin_address = '127.0.0.1',
  $internal_address = '127.0.0.1',
  $port = '8386',
  $version = 'v1.1',
) {
  if $service_name == undef {
    $real_service_name = $auth_name
  } else {
    $real_service_name = $service_name
  }

  keystone_service { $real_service_name:
    ensure      => present,
    type        => $service_type,
    description => $service_description,
  }

  keystone_endpoint { "${region}/${real_service_name}":
    ensure       => present,
    public_url   => "${public_protocol}://${public_address}:${port}/${version}/%(tenant_id)s",
    admin_url    => "${admin_protocol}://${admin_address}:${port}/${version}/%(tenant_id)s",
    internal_url => "${internal_protocol}://${internal_address}:${port}/${version}/%(tenant_id)s",
  }
}
