user = ACN::Helper.current_user
default['grails']['user'] = user
default['grails']['version'] = ''

default['intellij_idea']['user'] = user
default['intellij_idea']['version'] = '12.0.4'
default['intellij_idea']['file_name'] = "ideaIU-#{node[:intellij_idea][:version]}"
default['intellij_idea']['installation_folder'] = "#{ENV['HOME']}/Applications"
default['intellij_idea']['download_path'] = "#{Chef::Config[:file_cache_path]}/#{node[:intellij_idea][:file_name]}.tar.gz"
default['intellij_idea']['download_url'] = "http://download.jetbrains.com/idea/#{node[:intellij_idea][:file_name]}.tar.gz"