# ex: syntax=ruby ts=2 sw=2 si et
require 'ipaddr'

module Puppet::Parser::Functions
  newfunction(:ip_network, :type => :rvalue) do |args|
    cidr = args[0]
    offset = args[1] || '0'
    IPAddr.new(args[0]).to_range.to_a[offset.to_i].to_s
  end
end
