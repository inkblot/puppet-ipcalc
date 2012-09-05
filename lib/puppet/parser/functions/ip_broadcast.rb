require 'ip'

module Puppet::Parser::Functions

	newfunction(:ip_broadcast, :type => :rvalue) do |args|
		case args.length
		when 1
			IP.new(args[0]).broadcast
		when 2
			IP.new(args[0]).broadcast(args[1])
		end
	end

end
