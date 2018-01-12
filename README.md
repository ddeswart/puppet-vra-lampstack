# Additional Puppet code for vRealize Automation Plug-in Starter Content Pack for vRA 7.3 and Puppet plug-in for vRealize 3.0

This Puppet code adds additional Modules, Manifests, Profiles and Roles for deploying a LAMP stack using a multi-machine vRA 7.3 blueprint.

LAMP is an open source Web development platform that uses Linux as the operating system, Apache as the Web server, MySQL as the relational database management system and PHP as the object-oriented scripting language. Because the platform has four layers, LAMP is sometimes referred to as a LAMP stack. Stacks can be built on different operating systems.

The LAMP stack consists of two server Roles, mysql and webapp. One installs a MySQL database server and the other installs a Apache/PHP web server.

Use vRA Custom Properties to define database name, user and password during request. The default property naming used in site/profile/manifests/lamp/mysql.pp is:
- lamp_db_name
- lamp_db_user
- lamp_db_password

After a succesful deployment, open a webbrowser and type in http://[IP adress/FQDN of your webapp server] to verify the database connection. 

Prerequisites:
For using this code you must have Puppet Enterprise 7.x and VMware vRealize Automation 7.3 with Puppet plug-in 3.0 installed. Also the Puppet-vRO-Starter_Content pack has to be installed because the LAMP stack depends on several Profiles available in this Starter_Content.

To use this code, download and add it your Puppet code repository.

Special thanks for creation and testing of this LAMP content to Jeremy Adams and Kevin Reeuwijk from Puppet!


## Getting started with Puppet Enterprise and Puppet plug-in for vRealize Automation

Here's your high-level plan to get started with vRA 7.3 Enterprise to take advantage of the new GUI Puppet components:
- Create a Puppet Enterprise master and follow the instructions at the bottom of this page to install the starter content.
- [Remove any previous Puppet plug-ins](https://docs.puppet.com/pe/latest/vro_intro.html#removing-previous-versions-of-the-puppet-plug-in) and install the [Puppet plug-in for vRealize Automation 3.0](https://solutionexchange.vmware.com/store/products/puppet-plugin-for-vrealize-automation) into vRO.
- Follow the [vRA 7.3 docs to add a Puppet endpoint](https://docs.vmware.com/en/vRealize-Automation/7.3/com.vmware.vra.prepare.use.doc/GUID-7F7059C8-E80F-42E8-B0AE-32F794C6FC38.html) (points to your master), and create your Puppet Enterprise blueprints using code from this repo that is now on your PE master.
  * Puppet endpoint - username: [vro-plugin-user](https://github.com/puppetlabs/puppet-vro-starter_content/blob/production/modules/vro_plugin_user/manifests/init.pp#L7)
  * Puppet endpoint - password: [puppetlabs](https://github.com/puppetlabs/puppet-vro-starter_content/blob/production/modules/vro_plugin_user/manifests/init.pp#L8-L9)
  * Puppet endpoint - use sudo: [true](https://github.com/puppetlabs/puppet-vro-starter_content/blob/production/modules/vro_plugin_user/templates/vro_sudoer_file.epp)
  * Puppet component on blueprints - shared secret (cert autosigning): [S3cr3tP@ssw0rd!](https://github.com/puppetlabs/puppet-vro-starter_content/blob/production/modules/autosign_example/manifests/init.pp#L1)

> Note: if you are using vRealize 6.x or 7.0 through 7.2, then use the ["iaas_eventbroker" branch](https://github.com/puppetlabs/puppet-vro-starter_content/tree/iaas_eventbroker) of this repo.

vRA 7.3 Puppet docs:
- [Create a Puppet Endpoint](https://docs.vmware.com/en/vRealize-Automation/7.3/com.vmware.vra.prepare.use.doc/GUID-7F7059C8-E80F-42E8-B0AE-32F794C6FC38.html)
- [Creating Puppet Enabled vSphere Blueprints](https://docs.vmware.com/en/vRealize-Automation/7.3/com.vmware.vra.prepare.use.doc/GUID-45BF018B-0C25-489D-89AA-8A7C91E7E9A6.html)
- [Add a Puppet Component to a vSphere Blueprint](https://docs.vmware.com/en/vRealize-Automation/7.3/com.vmware.vra.prepare.use.doc/GUID-BB99F78C-1638-4852-92B7-30348E8EBBA2.html)
- [vRealize Automation 7.3 Release Notes](https://docs.vmware.com/en/vRealize-Automation/7.3/rn/vrealize-automation-73-release-notes.html)

Please see the [Puppet plug-in for vRealize documentation](https://docs.puppet.com/pe/latest/vro_intro.html) for more detailed information.

## Install Starter Content on your PE Master

Installation with git
```
git clone https://github.com/puppetlabs/puppet-vro-starter_content.git
cd puppet-vro-starter_content
sudo bash scripts/vra_nc_setup.sh
sudo /opt/puppetlabs/bin/puppet agent -t
```

Installation with curl
```
curl -sSL https://github.com/puppetlabs/puppet-vro-starter_content/archive/production.tar.gz | tar -zx
cd puppet-vro-starter_content-production
sudo bash scripts/vra_nc_setup.sh
sudo /opt/puppetlabs/bin/puppet agent -t
```

