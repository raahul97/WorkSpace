#
# Cookbook Name:: groovy
# Recipe:: default
#
# Copyright (C) 2012 Kyle Allan (<kallan@riotgames.com>)
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "java"
include_recipe "ark"

remote_file "/usr/local/groovy/lib/groovy-wslite-0.8.0.jar" do
  source "http://search.maven.org/remotecontent?filepath=com/github/groovy-wslite/groovy-wslite/0.8.0/groovy-wslite-0.8.0.jar"
  mode 00644
end


