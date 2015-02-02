# ex: syntax=ruby ts=2 sw=2 si et
require 'ipaddr'

module Puppet::Parser::Functions
  newfunction(:ip_network, :type => :rvalue) do |args|
    PuppetX::Ip.new(args[0]).network((args[1] || '0').to_i)
  end
end
