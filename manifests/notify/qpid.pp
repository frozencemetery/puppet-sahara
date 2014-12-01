# == Class: sahara::notify::qpid
#
#  Qpid broker configuration for Sahara
#
# === Parameters
#
# [*durable_queues*]
#   (Optional) Use durable queues in broker.
#   Defaults to false.
#
# [*qpid_hostname*]
#   (Optional) IP or hostname of the qpid server.
#   Defaults to '127.0.0.1'.
#
# [*qpid_port*]
#   (Optional) Port of the qpid server.
#   Defaults to 5672.
#
# [*qpid_username*]
#   (Optional) User to connect to the qpid server.
#   Defaults to 'guest'.
#
# [*qpid_password*]
#   (Optional) Password to connect to the qpid server.
#   Defaults to 'guest'.
#
# [*qpid_sasl_mechanisms*]
#   (Optional) String of SASL mechanisms to use.
#   Defaults to ''.
#
# [*qpid_heartbeat*]
#   (Optional) Seconds between connection keepalive heartbeats.
#   Defaults to 60.
#
# [*qpid_use_ssl*]
#   (Optional) Whether to use SSL.  (False => TCP)
#   Defaults to false.
#
# [*qpid_tcp_nodelay*]
#   (Optional) Whether to disable the Nagle algorithm.
#   Defaults to true.
#
# [*qpid_receiver_capacity*]
#   (Optional) Number of prefetched messages to hold.
#   Defaults to 1.
#
# [*qpid_topology_version*]
#   (Optional) Version of qpid toplogy to use.
#   Defaults to 2.
#
# [*notification_topics*]
#   (Optional) Topic to use for notifications.
#   Defaults to 'notifications'.
#
# [*control_exchange*]
#   (Optional) The default exchange to scope topics.
#   Defaults to 'openstack'.
#
class sahara::notify::rabbit(
  $durable_queues = false,
  $qpid_hostname = 'localhost',
  $qpid_port = 5672,
  $qpid_username = 'guest',
  $qpid_password = 'guest',
  $qpid_sasl_mechanisms = '',
  $qpid_heartbeat = 60,
  $qpid_use_ssl = false,
  $qpid_tcp_nodelay = true,
  $qpid_receiver_capacity = 1,
  $qpid_topology_version = 2,
  $notification_topics = 'notifications',
  $control_exchange = 'openstack',
) {
  if $qpid_use_ssl {
    $qpid_protocol = 'ssl'
    fail('SSL configuration of message broker is not yet supported!')
  } else {
    $qpid_protocol = 'tcp'
  }
  
  sahara_config {
    'DEFAULT/rpc_backend': value => 'qpid';
    'DEFAULT/qpid_hosts': value => '$qpid_hostname:$qpid_port';

    'DEFAULT/amqp_durable_queues': value => $durable_queues;
    'DEFAULT/qpid_hostname': value => $qpid_hostname;
    'DEFAULT/qpid_port': value => $qpid_port;
    'DEFAULT/qpid_username': value => $qpid_username;
    'DEFAULT/qpid_password':
      value => $qpid_password,
      secret => true;
    'DEFAULT/qpid_sasl_mechanisms': value => $qpid_sasl_mechanisms;
    'DEFAULT/qpid_heartbeat': value => $qpid_heartbeat;
    'DEFAULT/qpid_protocol': value => $qpid_protocol;
    'DEFAULT/qpid_tcp_nodelay': value => $qpid_tcp_nodelay;
    'DEFAULT/qpid_receiver_capacity': value => $qpid_receiver_capacity;
    'DEFAULT/qpid_topology_version': value => $qpid_topology_version;
    'DEFAULT/notification_topics': value => $notification_topics;
    'DEFAULT/control_exchange': value => $control_exchange;
  }
}

