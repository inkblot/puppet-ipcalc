# ex: syntax=ruby ts=2 sw=2 si et
require 'ipaddr'

module Puppet::Parser::Functions
  newfunction(:ip_network, :type => :rvalue) do |args|
    cidr = args[0]
    offset = args[1] || '0'
    (address, prefixlen) = cidr.split(/\//)
    prefixlen ||= '32'
    "#{IPAddr.new(cidr).to_range.to_a[offset.to_i].to_s}/#{prefixlen}"
  end
end
