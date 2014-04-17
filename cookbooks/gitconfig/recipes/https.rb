bash "update gitconfig to use https for GitHub and InnerSource" do
   user "root"
   code <<-EOH
	git config --global url.https://github.com/.insteadOf git://github.com/
	EOH
end


