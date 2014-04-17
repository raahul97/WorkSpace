bash "install Chrome" do
   user "root"
   cwd "/tmp/"
   code <<-EOH
	sudo apt-get install libxss1
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome*.deb
	EOH
end



