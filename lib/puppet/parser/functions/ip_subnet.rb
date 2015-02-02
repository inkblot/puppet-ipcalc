# ex: syntax=ruby ts=2 sw=2 si et
require 'puppetx/ip'

module Puppet::Parser::Functions
  newfunction(:ip_subnet, :type => :rvalue) do |args|
    PuppetX::Ip.new(args[0]).subnet(args[1].to_i, (args[2] || '0').to_i)
  end
end
