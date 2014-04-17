bash "install Tomcat" do

   user "root"

   cwd  "/tmp/"

   code <<-EOH

	wget http://mirrors.sonic.net/apache/tomcat/tomcat-7/v7.0.52/bin/apache-tomcat-7.0.52.tar.gz

	mkdir ~/tomcat/

	tar -zvxf apache-tomcat-7.0.52.tar.gz -C ~/tomcat/

	sudo chmod -R 755 ~/tomcat/

	EOH

end
