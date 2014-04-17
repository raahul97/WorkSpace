user = node[:eclipse][:user]
installation_path = node[:eclipse][:installation_folder]
already_installed = lambda { Dir.glob("#{installation_path}/Eclipse*").any? }

# Install IDE
directory installation_path do
  user user
  group user
  action :create
end

download_path = node[:eclipse][:download_path]
remote_file download_path do
  user user
  group user
  source node[:eclipse][:download_url]
  action :create_if_missing
  not_if &already_installed
end

bash "unzip IDE" do
  user user
  code <<-EOH
    tar xfz #{download_path} -C #{installation_path} --overwrite
  EOH
  not_if &already_installed
end

# Create launcher shortcut
#directory "#{ENV['HOME']}/.local/share/applications" do
#  user user
#  group user
#  recursive true
#  action :create
#end

#template "#{ENV['HOME']}/.local/share/applications/jetbrains-eclipse.desktop" do
#  owner user
#  group user
#  source "jetbrains-eclipse.desktop.erb"
#  not_if &already_installed
#end
