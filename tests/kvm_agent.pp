
package { 'cloudstack-agent':
  ensure => present,
}


file_line { 'vnc_listen':
  require => Package [ 'cloudstack-agent' ],
  path => '/etc/libvirt/qemu.conf',
  line => 'vnc_listen="0.0.0.0"',
  notify  => Service [ 'libvirtd' ],
}


augeas { 'libvirt_configuration':
  require => Package [ 'cloudstack-agent' ],
  context => '/files/etc/libvirt/libvirtd.conf',
  changes => [
    'set listen_tls 0',
    'set listen_tcp 1',
    'set tcp_port "16059"',
    'set auth_tcp "none"',
    'set mdns_adv 0',
  ],
}

augeas { 'libvirt_sys_conf':
  require => Augeas [ 'libvirt_configuration' ],
  context => '/files/etc/sysconfig/libvirtd',
  changes => [
    'set LIBVIRTD_ARGS "--listen"',
  ],
  notify  => Service [ 'libvirtd' ],
}

service { 'libvirtd':
  ensure => running,
  enable => true,
  require => Augeas [ 'libvirt_sys_conf' ],
}
