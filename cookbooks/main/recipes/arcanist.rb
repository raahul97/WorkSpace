user = ACN::Helper.current_user

install_path = node[:arcanist][:path]
arcanist_path = "#{install_path}/arcanist"
libphuntil_path = "#{install_path}/libphutil"

directory install_path do
  user user
  group user
  action :create
end

git libphuntil_path do
  repository "git://github.com/facebook/libphutil.git"
  reference "master"
  action :sync
end

git arcanist_path do
  repository "git://github.com/facebook/arcanist.git"
  reference "master"
  action :sync
end

# Idea from: http://stackoverflow.com/questions/12090914/updating-file-using-file-chef-solo-resource
ruby_block "add arcanist to PATH" do
  block do
    file = Chef::Util::FileEdit.new("#{ENV['HOME']}/.bash_profile")
    file.insert_line_if_no_match(
        "#{arcanist_path}/bin",
        "export PATH=\"#{arcanist_path}/bin:$PATH\" "
    )
    file.write_file
    file = Chef::Util::FileEdit.new("#{ENV['HOME']}/.bashrc")
    file.insert_line_if_no_match(
        "#{arcanist_path}/bin",
        "export PATH=\"#{arcanist_path}/bin:$PATH\" "
    )
    file.write_file
  end
end

# Required to run `source ~/.bash_profile` afterwards
