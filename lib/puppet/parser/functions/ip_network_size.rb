# ex: syntax=ruby ts=2 sw=2 si et
begin
  require 'puppetx/ip'
rescue LoadError => e
  # work around for puppet bug SERVER-973
  Puppet.info('Puppet did not autoload from the lib directory... falling back to relative path load.')
  require File.join(File.expand_path(File.join(__FILE__, '../../../..')), 'puppetx/ip')
end

module Puppet::Parser::Functions
  newfunction(:ip_network_size, :type => :rvalue) do |args|
    PuppetX::Ip.new(args[0]).network_size
  end
end
