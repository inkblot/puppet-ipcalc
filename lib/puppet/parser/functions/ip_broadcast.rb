require 'ip'

module Puppet::Parser::Functions

	newfunction(:ip_broadcast, :type => :rvalue) do |args|
		case args.length
		when 1
			IP.new(args[0]).broadcast.to_addr
		when 2
			IP.new(args[0]).broadcast(args[1]).to_addr
		end
	end

end
