require 'ip'

module Puppet::Parser::Functions

	newfunction(:ip_address, :type => :rvalue) do |args|
		IP.new(args[0]).to_addr
	end

end
