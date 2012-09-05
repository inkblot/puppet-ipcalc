require 'ip'

module Puppet::Parser::Functions

	newfunction(:ip_prefixlength, :type => :rvalue) do |args|
		IP.new(args[0]).pfxlen
	end

end
