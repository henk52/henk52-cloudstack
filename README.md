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


---

Debug: Prefetching mysql resources for mysql_user
Debug: Executing '/usr/bin/mysql --defaults-extra-file=/root/.my.cnf -NBe SELECT CONCAT(User, '@',Host) AS User FROM mysql.user'
Debug: Executing '/usr/bin/mysql --defaults-extra-file=/root/.my.cnf -NBe SELECT MAX_USER_CONNECTIONS, MAX_CONNECTIONS, MAX_QUESTIONS, MAX_UPDATES, PASSWORD FROM mysql.user WHERE CONCAT(user, '@', host) = 'root@127.0.0.1''
Debug: Executing '/usr/bin/mysql --defaults-extra-file=/root/.my.cnf -NBe SELECT MAX_USER_CONNECTIONS, MAX_CONNECTIONS, MAX_QUESTIONS, MAX_UPDATES, PASSWORD FROM mysql.user WHERE CONCAT(user, '@', host) = '@localhost''
Debug: Executing '/usr/bin/mysql --defaults-extra-file=/root/.my.cnf -NBe SELECT MAX_USER_CONNECTIONS, MAX_CONNECTIONS, MAX_QUESTIONS, MAX_UPDATES, PASSWORD FROM mysql.user WHERE CONCAT(user, '@', host) = 'root@localhost''
Debug: Executing '/usr/bin/mysql --defaults-extra-file=/root/.my.cnf -NBe SELECT MAX_USER_CONNECTIONS, MAX_CONNECTIONS, MAX_QUESTIONS, MAX_UPDATES, PASSWORD FROM mysql.user WHERE CONCAT(user, '@', host) = '@localhost.localdomain''
Debug: Executing '/usr/bin/mysql --defaults-extra-file=/root/.my.cnf -NBe SELECT MAX_USER_CONNECTIONS, MAX_CONNECTIONS, MAX_QUESTIONS, MAX_UPDATES, PASSWORD FROM mysql.user WHERE CONCAT(user, '@', host) = 'root@localhost.localdomain''
Debug: Exec[install_cloud_db](provider=posix): Executing 'cloudstack-setup-databases cloud:SecretPassword@localhost --deploy-as=root'
Debug: Executing 'cloudstack-setup-databases cloud:SecretPassword@localhost --deploy-as=root'
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Mysql user name:cloud                                                           [ OK ]
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Mysql user password:******                                                      [ OK ]
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Mysql server ip:localhost                                                       [ OK ]
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Mysql server port:3306                                                          [ OK ]
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Mysql root user name:root                                                       [ OK ]
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Mysql root user password:******                                                 [ OK ]
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Checking Cloud database files ...                                               [ OK ]
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Checking local machine hostname ...                                             [ OK ]
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Checking SELinux setup ...                                                      [ OK ]
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Detected local IP address as 127.0.0.1, will use as cluster management server node IP[ OK ]
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Preparing /etc/cloudstack/management/db.properties                              [ OK ]
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Applying /usr/share/cloudstack-management/setup/create-database.sql             
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: 
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: We apologize for below error:
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: ***************************************************************
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Encountering an error when executing mysql script
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: ----------------------------------------------------------------------
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: table:
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: /usr/share/cloudstack-management/setup/create-database.sql
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: 
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Error:
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: NO)
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: 
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: 
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Sql parameters:
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: {'host': 'localhost', 'user': 'root', 'port': 3306}
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: ----------------------------------------------------------------------
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns:             
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: ***************************************************************
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: Please run:
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: 
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns:     cloud-setup-database -h
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: 
Notice: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: for full help
Error: cloudstack-setup-databases cloud:SecretPassword@localhost --deploy-as=root returned 1 instead of one of [0]
Error: /Stage[main]/Cloudstack/Exec[install_cloud_db]/returns: change from notrun to 0 failed: cloudstack-setup-databases cloud:SecretPassword@localhost --deploy-as=root returned 1 instead of one of [0]
Debug: Finishing transaction 70273792431280
Debug: Storing state
Debug: Stored state in 0.04 seconds
Notice: Finished catalog run in 0.77 seconds
Debug: Using settings: adding file resource 'rrddir': 'File[/var/lib/puppet/rrd]{:ensure=>:directory, :links=>:follow, :group=>"puppet", :backup=>false, :owner=>"puppet", :mode=>"750", :path=>"/var/lib/puppet/rrd", :loglevel=>:debug}'
Debug: Finishing transaction 70273790989400
Debug: Received report to process from localhost
Debug: Processing report from localhost with processor Puppet::Reports::Store
[root@localhost cloudstack]# cloud-setup-database -h
-bash: cloud-setup-database: command not found
[root@localhost cloudstack]# cloudstack-setup-databases cloud:SecretPassword@localhost --deploy-as=root
Mysql user name:cloud                                                           [ OK ]
Mysql user password:******                                                      [ OK ]
Mysql server ip:localhost                                                       [ OK ]
Mysql server port:3306                                                          [ OK ]
Mysql root user name:root                                                       [ OK ]
Mysql root user password:******                                                 [ OK ]
Checking Cloud database files ...                                               [ OK ]
Checking local machine hostname ...                                             [ OK ]
Checking SELinux setup ...                                                      [ OK ]
Detected local IP address as 10.1.233.85, will use as cluster management server node IP[ OK ]
Preparing /etc/cloudstack/management/db.properties                              [ OK ]
Applying /usr/share/cloudstack-management/setup/create-database.sql             [ OK ]
Applying /usr/share/cloudstack-management/setup/create-schema.sql               [ OK ]
Applying /usr/share/cloudstack-management/setup/create-database-premium.sql     [ OK ]
Applying /usr/share/cloudstack-management/setup/create-schema-premium.sql       [ OK ]
Applying /usr/share/cloudstack-management/setup/server-setup.sql                [ OK ]
Applying /usr/share/cloudstack-management/setup/templates.sql                   [ OK ]
Applying /usr/share/cloudstack-bridge/setup/cloudbridge_db.sql                  [ OK ]
Applying /usr/share/cloudstack-bridge/setup/cloudbridge_schema.sql              [ OK ]
Applying /usr/share/cloudstack-bridge/setup/cloudbridge_multipart.sql           [ OK ]
Applying /usr/share/cloudstack-bridge/setup/cloudbridge_index.sql               [ OK ]
Applying /usr/share/cloudstack-bridge/setup/cloudbridge_multipart_alter.sql     [ OK ]
Applying /usr/share/cloudstack-bridge/setup/cloudbridge_bucketpolicy.sql        [ OK ]
Applying /usr/share/cloudstack-bridge/setup/cloudbridge_policy_alter.sql        [ OK ]
Applying /usr/share/cloudstack-bridge/setup/cloudbridge_offering.sql            [ OK ]
Applying /usr/share/cloudstack-bridge/setup/cloudbridge_offering_alter.sql      [ OK ]
Processing encryption ...                                                       [ OK ]
Finalizing setup ...                                                            [ OK ]

CloudStack has successfully initialized database, you can check your database configuration in /etc/cloudstack/management/db.properties
