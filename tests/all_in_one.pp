
#network::if::static { 'eth1':
#  ensure       => 'up',
#  ipaddress    => '10.1.233.10',
#  netmask      => '255.255.255.0',
#  gateway      => '10.1.233.3',
#}


# NTP p15-16
# TODO Fix this later.
#package { 'ntp':
#  ensure => present,
#}


#service { 'ntpd':
#  ensure => true,
#  enable => true,
#}  



# === NFS, p16+
#package { 'nfs-utils':
# ensure => present,
#}



$szPrimaryStorage   = '/primary'
$szSecondaryStorage = '/secondary'

$szDefaultNfsOptionList = 'rw,async,no_root_squash,no_subtree_check'
$szDefaultNfsClientList = '*'

$hNfsExports = {
 "$szPrimaryStorage" => {
             'NfsOptionList' => "$szDefaultNfsOptionList",
             'NfsClientList' => "$szDefaultNfsClientList",
                                        }, 
 "$szSecondaryStorage" => {
             'NfsOptionList' => "$szDefaultNfsOptionList",
             'NfsClientList' => "$szDefaultNfsClientList",
                                        }, 
}

file { "$szPrimaryStorage":
  ensure => directory,
}

file { "$szSecondaryStorage":
  ensure => directory,
}


# filewall stuff
#-A INPUT -s 172.16.10.0/24 -m state --state NEW -p udp --dport 111 -j ACCEPT
#-A INPUT -s 172.16.10.0/24 -m state --state NEW -p tcp --dport
# ...

class { 'nfsserver':
  require => File [ "$szPrimaryStorage", "$szSecondaryStorage" ],
   hohNfsExports => $hNfsExports,
#  NfsExport => $arNfsExports,
}

# === MySQL

$szMysqlRootPassword = 'strongpassword'

# TODO Change the password.
class { '::mysql::server':
  root_password    => "$szMysqlRootPassword",
}


class { 'cloudstack':
  require => Class [ '::mysql::server' ],
  szSecondaryStorageDirectory => "$szSecondaryStorage",
}

