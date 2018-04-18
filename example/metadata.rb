name 'chef_rvm_example'
maintainer 'R&R Innovation LLC'
maintainer_email 'work at murga.kiev.ua'
license 'Apache-2.0'
description 'Installs/Configures rvm'
long_description 'Example chef_rvm usage cookbook'
source_url 'https://github.com/RallySoftware-cookbooks/chef-rvm' if respond_to?(:source_url)
issues_url 'https://github.com/RallySoftware-cookbooks/chef-rvm/issues' if respond_to?(:issues_url)
chef_version '>= 12.5' if respond_to?(:chef_version)

version '0.1.0'

supports 'ubuntu'
supports 'debian'

depends 'chef_rvm'
depends 'build-essential'
depends 'java'
