#
# Cookbook Name:: gradle
# Recipe:: default
#
# Author:: Olle Hallin (<olle.hallin@crisp.se>)
#

include_recipe "java"
include_recipe "ark"

gradle_home = node[:gradle][:home]

ark "gradle" do
  url node[:gradle][:url]
  checksum node[:gradle][:checksum]
  home_dir node[:gradle][:home]
  version node[:gradle][:version]
  append_env_path true
  action :install
end

template "/etc/profile.d/gradle_home.sh" do
  mode 0755
  source "gradle_home.sh.erb"
  variables(:gradle_home => node[:gradle][:home])
end
# Idea from: http://stackoverflow.com/questions/12090914/updating-file-using-file-chef-solo-resource
ruby_block "add gradle to PATH" do
  block do
    file = Chef::Util::FileEdit.new("#{ENV['HOME']}/.bash_profile")
    file.insert_line_if_no_match(
        "#{gradle_home}/bin",
        "export PATH=\"#{gradle_home}/bin:$PATH\" "
    )
    file.write_file
    file = Chef::Util::FileEdit.new("#{ENV['HOME']}/.bashrc")
    file.insert_line_if_no_match(
        "#{gradle_home}/bin",
        "export PATH=\"#{gradle_home}/bin:$PATH\" "
    )
    file.write_file
  end
end


#bash "gradle_home" do
#  user "root"
#  code <<-EOH
#  export PATH=/usr/local/gradle/gradle-x.x/bin:$PATH
#  EOH
#  action :run
#end


