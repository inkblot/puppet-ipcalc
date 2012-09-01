require 'ip'

module Puppet::Parser::Functions

	newfunction(:ip_netmask, :type => :rvalue) do |args|
		IP.new(args[0]).netmask
	end

end
