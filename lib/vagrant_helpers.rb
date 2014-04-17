require 'open3'
require 'benchmark'

# Execute shell command and output STDOUT as it comes
def exec_stream(cmd)
  system(cmd)
  #pipe = IO.popen(cmd)
  #while (line = pipe.gets)
  #  print line
  #end
end

# Execute a shell command inside existing Vagrant and STREAM output
def vagrant_stream(cmd)
  exec_stream("vagrant ssh -c '#{cmd}'")
end

# Execute a shell command inside existing Vagrant
def vagrant_exec(cmd)
  `vagrant ssh -c "#{cmd}"`
end

# Is an application available in PATH?
def installed?(application)
  !vagrant_exec("which #{application}").strip.empty?
end

# TODO: Implement logging
def vagrant_log(cmd, options = {})
  options = {:title => cmd}.merge(options)
  print ">> #{options[:title]}..." unless options[:silent]
  time = Benchmark.realtime do
    `vagrant ssh -c "#{cmd}" 2>&1` # Redirect STDERR to STDOUT
  end
  puts " DONE (#{time} s)" unless options[:silent]
end

# TODO: Implement logging
def exec_log(cmd, options = {})
  options = {:title => cmd}.merge(options)
  print ">> #{options[:title]}..." unless options[:silent]
  time = Benchmark.realtime do
    `#{cmd} 2>&1` # Redirect STDERR to STDOUT
  end
  puts " DONE (#{time} s)" unless options[:silent]
end