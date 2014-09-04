henk52-cloudstack
=================

Puppet modules for Cloudstack installation.




# Getting the Cloudstack RPMs
wget -r -np -nH --cut-dirs=1 -R index.html http://cloudstack.apt-get.eu/rhel/4.4

http://bmwieczorek.wordpress.com/2008/10/01/wget-recursively-download-all-files-from-certain-directory-listed-by-apache/

sudo cp -r 4.4 /var/ks/repo
sudo mv /var/ks/repo/4.4 /var/ks/repo/cloudstack_4.4


= Troubleshooting =

Error: Execution of '/usr/bin/yum -d 0 -e 0 -y install cloudstack-management' returned 1: Error: Package: cloudstack-management-4.4.0-NONOSS_3.el6.x86_64 (cloudstack)
           Requires: java7
Error: Package: cloudstack-management-4.4.0-NONOSS_3.el6.x86_64 (cloudstack)
           Requires: tomcat6
Error: Package: cloudstack-common-4.4.0-NONOSS_3.el6.x86_64 (cloudstack)
           Requires: python(abi) = 2.6
           Installed: python-2.7.5-13.fc20.x86_64 (@f20_x86_64_update)
               python(abi) = 2.7
               python(abi) = 2.7
           Available: python-2.7.5-9.fc20.i686 (distribution-manager-everything)
               python(abi) = 2.7
               python(abi) = 2.7
           Available: python3-3.3.2-8.fc20.i686 (distribution-manager-everything)
               python(abi) = 3.3
           Available: python3-3.3.2-17.fc20.i686 (distribution-manager-updates)
               python(abi) = 3.3
 You could try using --skip-broken to work around the problem
 You could try running: rpm -Va --nofiles --nodigest

Error: /Stage[main]/Main/Package[cloudstack-management]/ensure: change from absent to present failed: Execution of '/usr/bin/yum -d 0 -e 0 -y install cloudstack-management' returned 1: Error: Package: cloudstack-management-4.4.0-NONOSS_3.el6.x86_64 (cloudstack)
           Requires: java7
Error: Package: cloudstack-management-4.4.0-NONOSS_3.el6.x86_64 (cloudstack)
           Requires: tomcat6
Error: Package: cloudstack-common-4.4.0-NONOSS_3.el6.x86_64 (cloudstack)
           Requires: python(abi) = 2.6
           Installed: python-2.7.5-13.fc20.x86_64 (@f20_x86_64_update)
               python(abi) = 2.7
               python(abi) = 2.7
           Available: python-2.7.5-9.fc20.i686 (distribution-manager-everything)
               python(abi) = 2.7
               python(abi) = 2.7
           Available: python3-3.3.2-8.fc20.i686 (distribution-manager-everything)
               python(abi) = 3.3
           Available: python3-3.3.2-17.fc20.i686 (distribution-manager-updates)
               python(abi) = 3.3
 You could try using --skip-broken to work around the problem
 You could try running: rpm -Va --nofiles --nodigest


