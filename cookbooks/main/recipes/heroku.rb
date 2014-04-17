require 'mkmf'

# Install Heroku
bash "install heroku toolbelt" do
  code <<-EOH
    wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
  EOH
  not_if { find_executable 'heroku' }
end