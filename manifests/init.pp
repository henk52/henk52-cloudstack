# == Class: cloudstack
#
# Full description of class cloudstack here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { cloudstack:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class cloudstack (
 $szRepoWebHostAddress = hiera( 'RepoWebHostAddress' ),
) {

# TODO N Do I need path, when it is the true file in the title?
#file { '/etc/yum.repos.d/cloudstack.repo':
#  path    => '/etc/yum.repos.d/cloudstack.repo',
#  ensure  => file,
#  content => template('cloudstack/cloudstack_repo.erb'),
#}

#exec { '/usr/bin/yum clean all':
#  subscribe => File['/etc/yum.repos.d/cloudstack.repo'],
#}

# TODO Call the NTP class for this.
package { 'ntp':
  ensure => present,
}


package { 'mysql-server':
  ensure => present,
}

# TODO V Make this optional if you are running from a local repo.
file_line { 'cloudstack.apt-get.eu':
  path => '/etc/hosts',
  line => "$szRepoWebHostAddress  cloudstack.apt-get.eu",
}

package { 'cloudstack-management':
  ensure  => present,
  require => File_line [ 'cloudstack.apt-get.eu' ],
}

$szPrimaryStorageDirectory = hiera( 'PrimaryStorageDirectory', '/primary' )
$szSecondaryStorageDirectory = hiera( 'SecondaryStorageDirectory', '/secondary' )


file { "$szPrimaryStorageDirectory":
  ensure => directory,
}
file { "$szSecondaryStorageDirectory":
  ensure => directory,
}
$szDefaultNfsOptionList =  'rw,async,no_root_squash,no_subtree_check'
$szDefaultNfsClientList = hiera ( 'DefaultNfsClientList', '*' )

$hNfsExports = {
 "$szPrimaryStorageDirectory" => {
             'NfsOptionList' => "$szDefaultNfsOptionList",
             'NfsClientList' => "$szDefaultNfsClientList",
                               }, 
 "$szSecondaryStorageDirectory" => {
             'NfsOptionList' => "$szDefaultNfsOptionList",
             'NfsClientList' => "$szDefaultNfsClientList",
                             }, 
}
class { 'nfsserver':
   hohNfsExports => $hNfsExports,
}

}
