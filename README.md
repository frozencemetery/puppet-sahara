sahara
======

5.0.0 - 2014.2.0 - Juno

#### Table of Contents

1. [Overview - What is the sahara module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with sahara](#setup)
4. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Contributors - Those with commits](#contributors)
8. [Release Notes - Notes on the most recent updates to the module](#release-notes)

Overview
--------

- [ ] TODO

Module Description
------------------

- [ ] TODO

Setup
-----

**What the sahara module affects:**

* sahara, the hadoop clustering service for Openstack.

### Installing sahara

- [ ] TODO

### Beginning with sahara

To utilize the sahara module's functionality you will need to declare multiple
resources.  This is not an exhaustive list of all the components needed; we
recommend you consult and understand the
[core of openstack](http://docs.openstack.org) documentation.

```puppet
# first, create a database
class { 'sahara::db::mysql':
  password => 'a_big_secret',
}

# Then the common class
class { 'sahara':
  database_connection => 'mysql://sahara:a_big_secret@127.0.0.1:3306/sahara',
  verbose => true,
  debug => true,
  os_username => 'admin',
  os_password => 'secrets_everywhere',
  os_tenant_name => 'admin',
  os_auth_url => 'http://127.0.0.1:5000/v2.0/',
  identity_url => 'http://127.0.0.1:35357/',
  service_host => '127.0.0.1',
  service_port => 8386,
  use_neutron => true,
}
```

Implementation
--------------

### sahara

- [ ] TODO

Limitations
-----------

- [ ] TODO

Development
-----------

- [ ] TODO

Contributors
------------

- [ ] TODO

Release Notes
-------------

**5.0.0**

* Rewrite
