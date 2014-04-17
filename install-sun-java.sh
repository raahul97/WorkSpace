#!/bin/bash
#
# Installs Sun Java for Ubuntu 12.04
#
# Supports Java 6 and 7 either 32-bit or 64-bit version
#
# This script will install the java archive, update the alternatives to make
# the newly install java the highest priority and set alternatives to use it.
#
# It will also configure the mozilla java plugin and either add or replace JAVA_HOME
# in /etc/environment leaving a backup file called /etc/environment~ maybe making that
# optional will be a future improvement.
#
# You can obtain the latest Sun Java from: http://www.oracle.com/technetwork/java/javase/downloads/
#
# This script is design to install only the SE JDK. Do not use it to install the JRE
#
# Do not use this script on the RPM installer, only on the .bin or .tar.gz archives
#
# The script needs to be run as sudo since it can't do much installing without it
#
# There are two arguments. The first is the required and is the name of the archive being
# installed. It doesn't have to be in the same directory as the install script. The second
# is optional and only applies to java 6. Add 'allow' if you want to let the script install
# 'expect' if it isn't currently installed. Expect is required for installing java 6. It's a
# tiny program that is very useful for automating tasks in bash scripts.
#
# Examples
#
# sudo ./install-sun-java.sh jdk-6u33-linux-x64.bin
#
# sudo ./install-sun-java.sh /home/dude/jdk-7u5-linux-x64.tar.gz
#
# sudo ./install-sun-java.sh Downloads/jdk-6u33-linux-i586.bin allow
#
# Upgrading Java
# 
# If the script is used a system with an existing java install, then the new version of java
# will be installed alongside with the new version added as the default alternative. You can 
# use 'update alternatives --config java' to manually select the older version if desired. Repeat
# for javac and javaws
#
#
# By Erik Larson
#
#

RETURN_VALUE=0

get-priority() {
  local priority=100   
  local command_name=$1
  while read line
  do
    if [[ $line =~ .*priority.([0-9]+)$ ]]; then
      echo $line
      local value=${BASH_REMATCH[1]}
      if [ ${value} -gt ${priority} ]; then
        priority=${value}
      fi
    fi
  done < <(update-alternatives --display ${command_name})
  let RETURN_VALUE=${priority}+1
}
                                                    
if [ "$(id -u)" != "0" ]; then
  echo "Must be run as superuser"
  exit 1
fi

if [ $# -lt 1 ]; then
  echo "usage: install-sun-java.sh <java installer archive or bin> <'allow' to let script install expect>" 
  exit 1 
fi

full_archive_name=$1

allow_apt_get=$2

if [ ! -f $full_archive_name ]; then
  echo "FATAL ERROR: File $full_archive_name not found"
  exit 1
fi

# Parse archive name
archive_path=$(dirname ${full_archive_name})
archive_file=$(basename ${full_archive_name})

if [[ $archive_file =~ ^jdk-([6-7]+)u([0-9]+)-linux-(i586|x64).* ]]; then
   major_version=${BASH_REMATCH[1]}
   update=$(printf "%02d" ${BASH_REMATCH[2]})  
   arch=${BASH_REMATCH[3]}
else
  echo "FATAL ERROR: $archive_file is not recognized as a java installer"
  exit 1
fi

jdk_version="1.${major_version}.0_${update}" 

echo "Installing Java Using JDK ${jdk_version}"

# Extract Files

echo "# Changing Directory"
cd ${archive_path}
echo $(pwd)
echo "#  Extracting Archive ${archive_file}"
if [ $major_version -eq "7" ]; then
  tar -zxvf ${archive_file}
else
  if [[ ! $(which expect) =~ .*expect.* ]]; then
    if [ "${allow_apt_get}" = "allow" ]; then
      apt-get -y install expect
    else
      echo "The program 'expect' is required to run the script."
      echo "You can run the script again and add the argument 'allow' to have the script automatically install it for you."
      echo "example: sudo ./install-sun-java.sh jdk-6u33-linux-x64.bin allow"
      exit 1
    fi
  fi
  chmod +x ${archive_file}
  expect <<EOD
    set timeout 300      
    spawn ./${archive_file}
    expect "Press Enter"
    send "\r"
    interact
EOD
fi

jdk_dir="jdk${jdk_version}"

# Confirm the directory

if [ ! -d $jdk_dir ]; then
  echo "FATAL ERROR: Can't find extracted directory"
  exit 1
fi

echo "# Move into jvm library..."

# Move Directory to jvm library
mkdir -p /usr/lib/jvm
mv -v ${jdk_dir} /usr/lib/jvm

# Set alternatives
echo "# Update Javac Alteratives..."
echo "# Don't worry if you see an error here - it just means there are no other versions of java installed"
get-priority "javac"
javac_priority=$RETURN_VALUE
update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/${jdk_dir}/bin/javac ${javac_priority}
update-alternatives --auto javac

echo "# Update Java Alteratives..."
echo "# Don't worry if you see an error here - it just means there are no other versions of java installed"
get-priority "java"
java_priority=$RETURN_VALUE
update-alternatives --install /usr/bin/java java /usr/lib/jvm/${jdk_dir}/bin/java ${java_priority}
update-alternatives --auto java

echo "# Update Javaws Alteratives..."
echo "# Don't worry if you see an error here - it just means there are no other versions of java installed"
get-priority "javaws"
javaws_priority=$RETURN_VALUE
update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/${jdk_dir}/bin/javaws ${javaws_priority}
update-alternatives --auto javaws

# Enable Java Plug for Mozilla
echo "# Enable Mozilla Java Plug-in..."
if [ -d /usr/lib/mozilla/plugins ]; then
  if [ $arch == "x64" ]; then
    ln -sf /usr/lib/jvm/${jdk_dir}/jre/lib/amd64/libnpjp2.so /usr/lib/mozilla/plugins  
  else
    ln -sf /usr/lib/jvm/${jdk_dir}/jre/lib/i386/libnpjp2.so /usr/lib/mozilla/plugins
  fi
else
  echo "# Mozilla not detected, skipping..."
fi

if [[ $(grep 'JAVA_HOME' /etc/environment) =~ ^JAVA_HOME ]]; then
  cp /etc/environment /etc/environment~
  sed "s@^JAVA_HOME=.*@JAVA_HOME=/usr/lib/jvm/${jdk_dir}@" < /etc/environment~ > /etc/environment
else
  echo "JAVA_HOME=/usr/lib/jvm/${jdk_dir}" >> /etc/environment
fi

# Ending Notes
echo "# Java is Installed..."
echo "# Use the command 'export JAVA_HOME=/usr/lib/jvm/${jdk_dir}' to use java right now."
echo "# The environment varible should be set system wide on restart."

# End by showing version
echo "# Show Version..."
java -version

exit 0
