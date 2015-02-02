# ex: syntax=ruby ts=2 sw=2 si et
require 'ipaddr'

module Puppet::Parser::Functions
  newfunction(:ip_prefixlength, :type => :rvalue) do |args|
    PuppetX::Ip.new(args[0]).prefixlength
  end
end
