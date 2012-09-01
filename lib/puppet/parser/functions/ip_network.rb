require 'ip'

module Puppet::Parser::Functions

	newfunction(:ip_network, :type => :rvalue) do |args|
		case args.length
		when 1
			IP.new(args[0]).network.to_addr
		when 2
			IP.new(args[0]).network(args[1].to_i).to_addr
		end
	end

end
