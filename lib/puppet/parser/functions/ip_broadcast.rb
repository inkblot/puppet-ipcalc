# ex: syntax=ruby ts=2 sw=2 si et
require 'puppetx/ip'

module Puppet::Parser::Functions
  newfunction(:ip_broadcast, :type => :rvalue) do |args|
    PuppetX::Ip.new(args[0]).broadcast((args[1] || '0').to_i)
  end
end
