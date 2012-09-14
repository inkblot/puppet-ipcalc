require 'ip'

module Puppet::Parser::Functions

	newfunction(:ip_network_size, :type => :rvalue) do |args|
		IP.new(args[0]).size
	end

end
