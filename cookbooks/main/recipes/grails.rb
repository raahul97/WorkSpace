require 'mkmf'

user = node[:grails][:user]

# Ensure JDK is in path
bash "set JAVA_HOME" do
  user user
  code 'export JAVA_HOME="/usr/lib/jvm/default-java"'
  only_if { `echo $JAVA_HOME`.strip.empty?  }
end

# Install GVM
bash "install_gvm" do
  user user
  code "curl -s get.gvmtool.net | bash"
  not_if { find_executable 'gvm' }
end

# Install Grails
bash "install grails" do
  user user
  code <<-EOH
    source "$HOME/.gvm/bin/gvm-init.sh"
    gvm install grails #{node[:grails][:version]}; true
  EOH
end