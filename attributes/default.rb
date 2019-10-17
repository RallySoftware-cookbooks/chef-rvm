default['chef_rvm']['packages'] = value_for_platform(
  ['centos', 'redhat', 'fedora'] => {
    default: %w[bash tar gzip git subversion sqlite-devel]
  },
  'ubuntu' => {
    default: %w[bash tar gzip git subversion]
  },
  'default' => %w[bash tar gzip git subversion]
)

default['chef_rvm']['keyserver'] = 'hkp://keyserver.ubuntu.com'
default['chef_rvm']['rvmrc']['rvm_gem_options'] = '--no-rdoc --no-ri'
default['chef_rvm']['rvmrc']['rvm_autoupdate_flag'] = 0
default['chef_rvm']['users'] = {}
default['chef_rvm']['verbose'] = false
