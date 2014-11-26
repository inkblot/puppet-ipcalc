# ex: syntax=ruby ts=2 sw=2 si et
require 'ipaddr'

module Puppet::Parser::Functions
  newfunction(:ip_network_size, :type => :rvalue) do |args|
    cidr = args[0]
    IPAddr.new(cidr).to_range.count
  end
end
