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
 $szSecondaryStorageDirectory,
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


# TODO V Make this optional if you are running from a local repo.
file_line { 'cloudstack.apt-get.eu':
  path => '/etc/hosts',
  line => "$szRepoWebHostAddress  cloudstack.apt-get.eu",
}


#package { 'java-1.7.0-openjdk-headless':
#  ensure => present,
#}

package { 'cloudstack-management':
  require => [
               File_line [ 'cloudstack.apt-get.eu' ],
             ],
  ensure  => present,
}


# TODO C make this work when running from puppet script.
# TODO V Somehow make sure the mysql is present, it is a requirement.
exec { 'install_cloud_db':
  creates => '/var/lib/mysql/cloud',
  path    => [ '/usr/bin', '/bin' ],
  require => [
                Package [ 'cloudstack-management' ],
              ],
  command => "cloudstack-setup-databases cloud:SecretPassword@localhost --deploy-as=root:$szMysqlRootPassword",
}


exec { 'cloudstack-setup-management':
  creates => '/var/log/cloudstack/management/setupManagement.log',
  command => 'cloudstack-setup-management',
  path    => '/usr/bin',
  require => Exec [ 'install_cloud_db' ],
}

exec { 'kvm_template_install':
  creates => "$szSecondaryStorageDirectory/template",
  command => "/usr/share/cloudstack-common/scripts/storage/secondary/cloud-install-sys-tmplt -m $szSecondaryStorageDirectory -u http://cloudstack.apt-get.eu/systemvm/4.4/systemvm64template-4.4.0-6-kvm.qcow2.bz2 -h kvm -F",
  path    => [ '/usr/bin', '/bin' ],
  require => Exec [ 'cloudstack-setup-management' ],
}

# /usr/share/cloudstack-common/scripts/storage/secondary/cloud-install-sys-tmplt \
#-m /mnt/secondary \
#-u http://cloudstack.apt-get.eu/systemvm/4.4/systemvm64template-4.4.0-6-kvm.qcow2.bz2 \ -h lxc \
#-s <optional-management-server-secret-key> \
#-F

}
