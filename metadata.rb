name 'chef_rvm'
maintainer 'CA'
maintainer_email 'operations-rally@ca.com'
license 'Apache-2.0'
description 'Installs/Configures rvm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://github.com/RallySoftware-cookbooks/chef-rvm' if respond_to?(:source_url)
issues_url 'https://github.com/RallySoftware-cookbooks/chef-rvm/issues' if respond_to?(:issues_url)
version '2.2.1'
chef_version '>= 12.5' if respond_to?(:chef_version)

recipe 'chef_rvm', 'Installs all'
recipe 'chef_rvm::rvm', 'Installs the rvm for users'
recipe 'chef_rvm::rubies', 'Installs rubies'
recipe 'chef_rvm::gems', 'Creates gemsets and install gems'
recipe 'chef_rvm::packages', 'General recipe. Installs dependencies for other recipes.'
recipe 'chef_rvm::wrappers', 'Create wrappers'
recipe 'chef_rvm::aliases', 'Create aliases'

supports 'ubuntu'
supports 'debian'

depends 'sudo'
depends 'build-essential'
depends 'chef_gem'
depends 'curl'

# if using jruby, java is required on system
depends 'java' # For jruby
depends 'maven' # For jruby
depends 'nodejs' # for opal
depends 'mono' # for ironruby
depends 'homebrew' # for jruby

# if installing on Debian-based distros
# depends 'apt'

# for installing on OSX, this is required for installation and compilation
# depends 'homebrew'
