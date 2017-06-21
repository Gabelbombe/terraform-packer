lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ehime_hello/version'

Gem::Specification.new do |spec|
  spec.name = 'ehime_hello'
  spec.version = ehimeHello::VERSION
  spec.authors = ['Chris Marchesi']
  spec.email = %w(chrism@ehimetech.com)
  spec.description = 'A hello world app for Sinatra, used to demonstrate a Packer/Terraform pattern'
  spec.summary = spec.description
  spec.homepage = 'https://github.com/ehime/terraform-packer'
  spec.license = 'Apache 2.0'

  spec.files = ['lib/ehime_hello.rb', 'lib/ehime_hello/version.rb', 'exe/ehime_hello']
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.bindir = 'exe'
  spec.require_paths = %w(lib)

  spec.required_ruby_version = ['>= 2.1']

  spec.add_dependency 'sinatra', '~> 1.4'
  spec.add_dependency 'thin', '~> 1.6'

  spec.add_development_dependency 'rake', '~> 10.5'
  spec.add_development_dependency 'test-kitchen', '~> 1.5'
  spec.add_development_dependency 'kitchen-ec2', '~> 0.10'
  spec.add_development_dependency 'ubuntu_ami', '~> 0.4'
  spec.add_development_dependency 'berkshelf', '~> 4.0'
  spec.add_development_dependency 'aws-sdk', '~> 2.2'
end
