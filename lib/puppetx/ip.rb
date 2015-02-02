# ex: syntax=ruby si sw=2 ts=2 et
require 'ipaddr'

module PuppetX; end

class PuppetX::Ip

  attr_reader :cidr, :address, :prefixlength

  def initialize(cidr)
    @cidr = IPAddr.new(cidr)
    (addr, prefixlen) = cidr.split(/\//)
    @address = IPAddr.new(addr)
    prefixlen ||= default_prefixlength
    @prefixlength = prefixlen.to_i
  end

  def netmask
    IPAddr.new(unicast_netmask).mask(prefixlength).to_s
  end

  def network_size
    range.count
  end

  def network(offset = 0)
    "#{range.to_a[offset].to_s}/#{prefixlength}"
  end

  def broadcast(offset = 0)
    "#{range.to_a[offset - 1].to_s}/#{prefixlength}"
  end

  def offset
    range.to_a.index(address)
  end

  def to_s
    address.to_s
  end

private

  def range
    cidr.to_range
  end

  def default_prefixlength
    address.ipv4? ? '32' : '128'
  end

  def unicast_netmask
    address.ipv4? ? '255.255.255.255' : 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
  end
end
