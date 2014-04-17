require 'lib/vagrant_helpers'

# Testing related
namespace :workstation do
  desc 'Destroy existing Vagrant instant'
  task :destroy do
    exec_log('vagrant halt', title: 'Halting any existing Vagrant')
    exec_log('vagrant destroy --force', title: 'Destroying (with force) any existing Vagrant')
  end

  namespace :test do
    desc 'Test AOWP workstation environment'
    task(:aowp) { install_workstation('aowp') }

    desc 'Test Rails workstation environment'
    task(:rails) { install_workstation('rails') }

    desc 'Test Grails workstation environment'
    task(:nodejs) { install_workstation('nodejs') }

    desc 'Test Node.JS workstation environment'
    task(:grails) { install_workstation('grails') }

    desc 'Test all workstation environments'
    task :default => [:aowp, :grails, :nodejs, :rails]
  end
end

# Install desired workstation
def install_workstation(workstation)
  time = Benchmark.realtime do
    puts "## Testing Workstation: #{workstation}"

    # Destroy any existing VM
    Rake::Task['workstation:destroy'].invoke

    # Bring up
    exec_log('vagrant up', title: 'Vagrant Up')

    # Bootstrap Chef
    cmd = 'bash /vagrant/bootstrap/ubuntu.sh' # Use local version (for development purposes)
    vagrant_log(cmd, title: 'Executing Bootstrap')

    # Execute Chef-solo
    cmd = "sudo chef-solo -c /vagrant/solo.rb -j /vagrant/workstations/#{workstation}.json"
    vagrant_log(cmd, title: "Setting up workstation: #{workstation}")

    # Execute test
    puts '>> Executing Tests'
    exec_stream("rspec spec/#{workstation}_spec.rb")

    exec_log('vagrant halt', title: 'Vagrant Halt')
  end

  puts ">> Overall Time: (#{time} s)"
  puts ''
end
