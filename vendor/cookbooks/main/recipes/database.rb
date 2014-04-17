# SQLite3
# - Useful for quick development
package "sqlite3"
package "libsqlite3-dev"

# PostgreSQL user setup
# - Useful for parity with Heroku development
node[:database][:users].each do |user|

  create_user_command = begin
    args = []
    args.push('-s') if user[:superuser]
    "sudo -u postgres createuser #{args.join('')} #{user[:username]};"
  end

  set_user_password = begin
    "sudo -u postgres psql -c \"ALTER USER #{user[:username]} " +
        "WITH PASSWORD '#{user[:password]}';\""
  end

  bash "create_user" do
    user "root"
    code <<-EOH
#{create_user_command} #{set_user_password}
    EOH
    not_if "sudo -u postgres psql -c \"\\du\" | grep #{user[:username]}"
  end
end

# MySQL user setup
# - Useful for parity with AWS development
node[:database][:users].each do |user|

  create_user_command = begin
    "echo \"GRANT ALL PRIVILEGES ON *.* TO '#{user[:username]}'@'localhost' " +
        "IDENTIFIED BY '#{user[:password]}' WITH GRANT OPTION;\" " +
        "| mysql -uroot -p#{node['mysql']['server_root_password']}"
  end

  bash "create_user" do
    user "root"
    code create_user_command
  end
end