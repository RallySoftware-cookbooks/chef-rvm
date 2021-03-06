include_recipe 'chef_rvm::rvm'
node['chef_rvm']['users'].each do |username, rvm|
  next unless rvm['rubies']
  rubies = rvm['rubies']
  rubies = Array(rubies) if rubies.is_a?(String)
  rubies.each do |version, action|
    resource_config = {}
    resource_config['version'] = version if version.is_a?(String)
    resource_config['action'] = action if action.is_a?(String)
    resource_config.merge!(action) if action.is_a?(Hash)
    chef_rvm_ruby "#{username}:#{resource_config['version']}" do
      user username
      version resource_config['version']
      default resource_config['default']
      patch resource_config['patch']
      action resource_config['action'] if resource_config['action']
    end
  end
end
