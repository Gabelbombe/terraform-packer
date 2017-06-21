require 'bundler/gem_tasks'
require 'ubuntu_ami'
require 'ehime_hello/version'
require 'aws-sdk'
require 'date'

# Return a default distro if not defined
def distro
  if ENV.include?('DISTRO')
    ENV['DISTRO']
  else
    'trusty'
  end
end

# Return a default region if not defined
def region
  if ENV.include?('REGION')
    ENV['REGION']
  else
    'us-east-1'
  end
end

# Return a default Terraform command if not defined
def tf_cmd
  if ENV.include?('TF_CMD')
    ENV['TF_CMD']
  else
    'apply'
  end
end

# Get an ubuntu AMI ID to build off of (for Packer)
def ubuntu_ami_id
  Ubuntu.release(distro).amis.find do |ami|
    ami.arch == 'amd64' &&
      ami.root_store == 'ebs-ssd' &&
      ami.region == region
  end.name
end

# Timestamp conversion for AMI timestamp.
def rfc3339_to_unix(timestamp)
  DateTime.rfc3339(timestamp).to_time.seconds
end

# Get the latest AMI ID that we have built (for Terraform)
def app_ami_id
  ec2 = Aws::EC2::Client.new(region: region)
  resp = ec2.describe_images(
    filters: [
      {
        name: 'tag:app_name',
        values: ['ehime_hello']
      }
    ]
  )
  fail 'No built application images found' if resp.images.length < 1
  images = resp.images.sort do |a, b|
    rfc3339_to_unix(b.creation_date) <=> rfc3339_to_unix(a.creation_date)
  end
  images[0].image_id
end

# Make sure I don't release/push this to rubygems by mistake
Rake::Task['release'].clear

# Also no system install
Rake::Task['install:local'].clear
Rake::Task['install'].clear

desc 'Vendors dependent cookbooks in berks-cookbooks (for Packer)'
task :berks_cookbooks do
  sh 'rm -rf berks-cookbooks'
  sh 'berks vendor -b cookbooks/packer_payload/Berksfile'
end

desc 'Create an application AMI with Packer'
task :ami => [:build, :berks_cookbooks] do
  sh "DISTRO=#{distro} \
   SRC_AMI=#{ubuntu_ami_id} \
   SRC_REGION=#{region} \
   APP_VERSION=#{ehimeHello::VERSION} \
   packer build packer/ami.json"
end

desc 'Deploy infrastructure using Terraform'
task :infrastructure do
  sh "DISTRO=#{distro} \
   TF_VAR_ami_id=#{app_ami_id} \
   TF_VAR_region=#{region} \
   terraform #{tf_cmd} terraform"
end

desc 'Run test-kitchen on packer_payload cookbook'
task :kitchen do
  sh "cd cookbooks/packer_payload && \
   KITCHEN_YAML=.kitchen.cloud.yml \
   AWS_KITCHEN_AMI_ID=#{ubuntu_ami_id} \
   AWS_KITCHEN_USER=ubuntu \
   AWS_REGION=#{region} \
   KITCHEN_APP_VERSION=#{ehimeHello::VERSION} \
   kitchen test"
end
