# ex: syntax=ruby ts=2 sw=2 si et
require 'ipaddr'

module Pupper::Parser::Functions
  newfunction(:ip_offset, :type => :rvalue) do |args|
    cidr = args[0]
    (address, prefixlen) = cidr.split(/\//)
    IPAddr.new(cidr).to_range.to_a.index(IPAddr.new(address))
  end
end
