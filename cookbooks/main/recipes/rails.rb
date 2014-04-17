# Frequently forgotten about Gems
rvm_gem_binary = "#{ENV['HOME']}/.rvm/bin/gem"
%w(bundler execjs therubyracer).each do |gem|
  gem_package gem do
    gem_binary rvm_gem_binary
  end
end

# Database setup
include_recipe "main::database"