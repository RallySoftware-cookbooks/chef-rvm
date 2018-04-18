default_action :install

property :gems, [String]
property :version, [String, NilClass], default: nil
property :user, [String], default: 'root'
property :ruby_string, [String], required: true

action :install do
  unless rvm.gemset?(ruby_string)
    Chef::Log.debug('Create gemset before installing gem')
    rvm.gemset_create(ruby_string)
  end

  if rvm.gem?(ruby_string, gems, version)
    Chef::Log.debug("Gem #{gems} #{version} already installed on gemset #{ruby_string} for user #{user}.")
  else
    Chef::Log.debug("Install gem #{gems} #{version} on gemset #{ruby_string} for user #{user}.")
    rvm.gem_install(ruby_string, gems, version)
    new_resource.updated_by_last_action(true)
  end
end

%i[update uninstall].each do |action_name|
  action action_name do
    if rvm.gem?(ruby_string, gems, version)
      Chef::Log.debug "#{action_name.to_s.capitalize} gem #{gems} #{version} from gemset #{ruby_string} for user #{user}."
      new_resource.updated_by_last_action(true)
    else
      Chef::Log.debug "Gem #{gems} #{version} is not installed on gemset #{ruby_string} for user #{user}."
    end
  end
end

action_class.class_eval do
  include ChefRvmCookbook::RvmResourceHelper
end
