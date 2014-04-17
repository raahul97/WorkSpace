user = node[:rubymine][:user]
installation_path = node[:rubymine][:installation_folder]
already_installed = lambda { Dir.glob("#{installation_path}/RubyMine*").any? }

# Install IDE
directory installation_path do
  user user
  group user
  action :create
end

rubymine_download_path = node[:rubymine][:download_path]
remote_file rubymine_download_path do
  user user
  group user
  source node[:rubymine][:download_url]
  action :create_if_missing
  not_if &already_installed
end

bash "unzip IDE" do
  user user
  code <<-EOH
    tar xfz #{rubymine_download_path} -C #{installation_path} --overwrite
  EOH
  not_if &already_installed
end

preference_folder = '.RubyMine50'
remote_directory "#{ENV['HOME']}/#{preference_folder}" do
  files_owner user
  files_group user
  owner user
  group user
  recursive true
  source "RubyMine/#{preference_folder}"
  not_if &already_installed
end

# A fix for remote_directory not properly setting permissions
bash "set folder permissions" do
  code <<-EOH
    chown -R #{user}:#{user} "#{ENV['HOME']}/#{preference_folder}"
  EOH
  not_if &already_installed
end

# Create launcher shortcut
directory "#{ENV['HOME']}/.local/share/applications" do
  user user
  group user
  recursive true
  action :create
  not_if &already_installed
end

template "#{ENV['HOME']}/.local/share/applications/jetbrains-rubymine.desktop" do
  owner user
  group user
  source "jetbrains-rubymine.desktop.erb"
  not_if &already_installed
end