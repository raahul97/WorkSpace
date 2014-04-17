bash "downoad Diffmerge" do
   not_if do ::File.exists?('/tmp/diffmerge_4.2.0.697.stable_amd64.deb') end
   user "root"
   cwd  "/tmp"
   code <<-EOH
	wget http://download-us.sourcegear.com/DiffMerge/4.2.0/diffmerge_4.2.0.697.stable_amd64.deb
	EOH
end
bash "install, and configure DiffMerge as git default" do
   user "root"
   cwd  "/tmp"
   code <<-EOH
	dpkg -i diffmerge_4.2.0.*.deb
	git config --global merge.tool diffmerge
	git config --global mergetool.diffmerge.cmd "/usr/bin/diffmerge --merge --result=\$MERGED \$LOCAL \$BASE \$REMOTE"
	git config --global mergetool.keepBackup false
 
	git config --global diff.tool diffmerge
	git config --global difftool.diffmerge.cmd "/usr/bin/diffmerge \$LOCAL \$REMOTE"
	EOH
end


