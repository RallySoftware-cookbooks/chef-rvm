include_recipe 'build-essential::default'
include_recipe 'java'
include_recipe 'chef_rvm'
include_recipe 'chef_rvm_example::user'

directory '/home/rvm-user/test' do
  owner 'rvm-user'
end

file '/home/rvm-user/test/Gemfile' do
  content <<~EOF
    source 'https://rubygems.org'

    gem 'nio4r', '~> 1.2.1'
    gem 'eye'
EOF
end

chef_rvm 'rvm-user' do
  rubies ['2.1']
  action :install
end

chef_rvm_ruby 'rvm-user:1.9.3' do
  user 'rvm-user'
  version '1.9.3'
end

chef_rvm_ruby 'jruby' do
  user 'rvm-user'
  version '9.1.7.0'
end

chef_rvm_ruby 'rvm-user:2.0.0' do
  user 'rvm-user'
  version '2.0.0'
  default true
end

chef_rvm_gemset 'rvm-user:gemset:2.0.0' do
  user 'rvm-user'
  ruby_string '2.0.0@test'
end

chef_rvm_gem 'rvm-user:gem:2.0.0@test:nio4r' do
  user 'rvm-user'
  ruby_string '2.0.0@test'
  gem 'nio4r'
  version '1.2.1'
end

chef_rvm_gem 'rvm-user:gem:2.0.0@test:eye' do
  user 'rvm-user'
  ruby_string '2.0.0@test'
  gem 'eye'
end

chef_rvm_gem 'rvm-user:2.0.0@test:eye:0.8.1' do
  user 'rvm-user'
  ruby_string '2.0.0@test'
  gem 'eye'
  version '0.8.1'
end

chef_rvm_wrapper 'rvm-user:wrapper:prefix_eye' do
  user 'rvm-user'
  ruby_string '2.0.0@test'
  prefix 'prefix'
  binary 'eye'
end

chef_rvm_gem 'rvm-user:1.9.3:cucumber' do
  user 'rvm-user'
  ruby_string '1.9.3'
  gem 'cucumber'
end

chef_rvm_gem 'rvm-user:2.0.0:bundler' do
  user 'rvm-user'
  ruby_string '2.0.0'
  gem 'bundler'
end

chef_rvm_execute 'bundle install' do
  ruby_string '2.0.0'
  user 'rvm-user'
  cwd '/home/rvm-user/test'
  command 'bundle install'
  not_if 'bundle check'
  action :run
end

chef_rvm_execute 'bundle install' do
  ruby_string '2.0.0'
  user 'rvm-user'
  cwd '/home/rvm-user/test'
  command 'bundle install'
  only_if 'bundle check'
  action :run
end

chef_rvm_script 'bundle_install_sh' do
  interpreter 'sh'
  ruby_string '2.0.0'
  user 'rvm-user'
  cwd '/home/rvm-user/test'
  code <<CODE
  bundle install
CODE
  not_if 'bundle check'
  action :run
end

chef_rvm_bash 'bundle_install' do
  ruby_string '2.0.0'
  user 'rvm-user'
  cwd '/home/rvm-user/test'
  code <<CODE
  bundle install
CODE
  action :run
  not_if 'bundle check'
end
