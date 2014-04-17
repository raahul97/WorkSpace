user = ACN::Helper.current_user

# Necessary due to how chef-solo is executed as admin
bash "update permissions" do
  code <<-EOH
    sudo chown -R -f #{user} /usr/local || true
    sudo chown -R -f #{user}:#{user} ~ || true
  EOH
end