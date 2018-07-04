
default_action :install

property :user, [String], required: true
property :version, [Array, String], required: true
property :patch, [String, NilClass], default: nil
property :default, [TrueClass, FalseClass, NilClass], default: nil

action :install do
  user = new_resource.user
  version = new_resource.version
  patch = new_resource.patch
  default = new_resource.default
  if rvm.ruby?(version)
    Chef::Log.debug "Ruby #{version} already installed for user #{user}"
  else
    requirements_install(version)
    Chef::Log.debug "Install ruby #{version} for user #{user}"
    rvm.ruby_install(version, patch)
    rvm.gemset_create(version)
  end
  rvm.ruby_set_default(version) if default
end

%i[remove uninstall reinstall].each do |action_name|
  action action_name do
    user = new_resource.user
    version = new_resource.version
    if rvm.ruby?(version)
      Chef::Log.debug "#{action_name.to_s.capitalize} ruby #{version} for user #{user}"
    else
      Chef::Log.debug "Ruby #{version} is not installed for user #{user}"
    end
  end
end

action_class.class_eval do
  include ChefRvmCookbook::RvmResourceHelper
  include ChefRvmCookbook::Requirements
end
