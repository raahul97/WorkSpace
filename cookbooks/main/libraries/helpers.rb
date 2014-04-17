module ACN
  module Helper
    # Return the user that called `sudo` command
    def self.current_user
      `echo $SUDO_USER`.chomp
    end
  end
end