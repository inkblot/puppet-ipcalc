# ex: syntax=ruby ts=2 sw=2 si et
require 'ipaddr'

module Puppet::Parser::Functions
  newfunction(:ip_broadcast, :type => :rvalue) do |args|
    cidr = args[0]
    offset = args[1].to_i || 0
    IPAddr.new(cidr).to_range.to_a[offset - 1]
  end
end
