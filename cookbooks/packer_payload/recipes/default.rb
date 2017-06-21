SRC_PATH = node['packer_payload']['source_path']
APP_VERSION = node['packer_payload']['app_version']

ruby_runtime '2.1' do
  provider :ruby_build
  action :install
end

ruby_gem "#{SRC_PATH}/vancluever_hello-#{APP_VERSION}.gem" do
  action :install
end

poise_service 'vancluever_hello' do
  command '/opt/ruby_build/builds/2.1/bin/vancluever_hello'
  user node['packer_payload']['app_user']
  directory node['packer_payload']['app_path']
end
