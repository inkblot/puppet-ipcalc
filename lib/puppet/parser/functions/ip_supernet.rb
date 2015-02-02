# ex: syntax=ruby ts=2 sw=2 si et
require 'puppetx/ip'

module Puppet::Parser::Functions
  newfunction(:ip_supernet, :type => :rvalue) do |args|
    PuppetX::Ip.new(args[0]).supernet(args[1].to_i)
  end
end
