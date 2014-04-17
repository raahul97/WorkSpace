require 'mkmf'

# Basic modules required for development
bash "install Yeoman, Grunt, Bower" do
  code <<-EOH
    npm install -g yo generator-webapp
  EOH
  not_if { find_executable 'yo' }
end

# Compass for SCSS support
rvm_gem_binary = "#{ENV['HOME']}/.rvm/bin/gem"
gem_package "compass" do
  gem_binary rvm_gem_binary
end