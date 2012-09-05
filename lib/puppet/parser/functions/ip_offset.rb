require 'ip'

module Pupper::Parser::Functions

	newfunction(:ip_offset, :type => :rvalue) do |args|
		IP.new(args[0]).offset
	end

end
