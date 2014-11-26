# ex: syntax=ruby ts=2 sw=2 si et
require 'ipaddr'

module Puppet::Parser::Functions
  newfunction(:ip_netmask, :type => :rvalue) do |args|
    cidr = args[0]
    (address, prefixlen) = cidr.split(/\//)
    ipaddr = IPAddr.new(address)
    prefixlen ||= (ipaddr.ipv4? ? '32' : '128')
    IPAddr.new(ipaddr.ipv4? ? '255.255.255.255' : 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff').mask(prefixlen.to_i).to_s
  end
end
