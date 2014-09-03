# Install cloudstack and kvm node on the same machine.
#  For testing cloudstack.

network::if::static { 'eth1':
  ensure       => 'up',
  ipaddress    => '10.1.233.10',
  netmask      => '255.255.255.0',
  gateway      => '10.1.233.3',
}
