# ex: syntax=ruby ts=2 sw=2 si et
require 'ipaddr'

module Puppet::Parser::Functions
  newfunction(:ip_prefixlength, :type => :rvalue) do |args|
    cidr = args[0]
    (address, prefixlen) = cidr.split(/\//)
    prefixlen || (IPAddr.new(address).ipv4? ? '32' : '128')
  end
end
