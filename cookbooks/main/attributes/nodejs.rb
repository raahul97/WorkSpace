user = ACN::Helper.current_user

default['webstorm']['user'] = user
default['webstorm']['version'] = '7.0.2'
default['webstorm']['file_name'] = "WebStorm-#{node[:webstorm][:version]}"
default['webstorm']['installation_folder'] = "#{ENV['HOME']}/Applications"
default['webstorm']['download_path'] = "#{Chef::Config[:file_cache_path]}/#{node[:webstorm][:file_name]}.tar.gz"
default['webstorm']['download_url'] = "http://download.jetbrains.com/webstorm/#{node[:webstorm][:file_name]}.tar.gz"