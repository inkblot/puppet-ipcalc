# ex: syntax=ruby ts=2 sw=2 si et
require 'ipaddr'

module Puppet::Parser::Functions
  newfunction(:ip_address, :type => :rvalue) do |args|
    cidr = args[0]
    (address, prefixlen) = cidr.split(/\//)
    IPAddr.new(address).to_s
  end
end
