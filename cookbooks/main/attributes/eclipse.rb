#
# Recipe Name:: eclipse
# Attributes:: eclipse
#
user = ACN::Helper.current_user

default['eclipse']['user'] = user
default['eclipse']['version'] = '4.3.1'
default['eclipse']['file_name'] = "Eclipse-#{node[:eclipse][:version]}"
default['eclipse']['installation_folder'] = "#{ENV['HOME']}/Applications"
default['eclipse']['download_path'] = "#{Chef::Config[:file_cache_path]}/#{node[:eclipse][:file_name]}.tar.gz"
default['eclipse']['download_url'] = "http://carroll.aset.psu.edu/pub/eclipse/technology/epp/downloads/release/kepler/SR1/eclipse-jee-kepler-SR1-linux-gtk-x86_64.tar.gz"


default['eclipse']['version'] = 'kepler'
default['eclipse']['release_code'] = 'R'
default['eclipse']['arch'] = kernel['machine'] =~ /x86_64/ ? "x86_64" : ""
default['eclipse']['suite'] = 'jee'

default['eclipse']['plugins'] = ''
#[{"http://download.eclipse.org/releases/kepler"=>"org.eclipse.egit.feature.group"}]
#,
#                                 {"http://download.eclipse.org/technology/m2e/releases"=>"org.eclipse.m2e.feature.feature.group"},
#                                 {"http://vrapper.sourceforge.net/update-site/stable"=>"net.sourceforge.vrapper.feature.group"}]

default['eclipse']['url'] = ''

case node['platform_family']
when "rhel", "fedora", 'debian'
  default['eclipse']['os'] = 'linux-gtk'
when "osx"
  default['eclipse']['os'] = 'macosx-cocoa'
end
