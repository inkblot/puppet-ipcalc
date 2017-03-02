# ex: syntax=ruby si sw=2 ts=2 et
require 'ipaddr'

module PuppetX; end

class PuppetX::Ip

  attr_reader :cidr, :address, :prefixlength

  def initialize(cidr)
    @cidr = IPAddr.new(cidr)
    (addr, mask) = cidr.split(/\//)
    @address = IPAddr.new(addr)
    if mask.nil?
      prefixlen = unicast_prefixlength
    elsif mask =~ /\A\d+\z/
      prefixlen = mask.to_i
    else
      m = IPAddr.new(mask)
      if m.family != @address.family
        raise ArgumentError, "address family is not same"
      end
      prefixlen = m.to_i.to_s(2).count('1')
    end
    @prefixlength = prefixlen.to_i
  end

  def netmask
    IPAddr.new(unicast_netmask).mask(prefixlength).to_s
  end

  def network_size
    range.count
  end

  def network(offset = 0)
    raise ArgumentError, 'offset out of bounds' if offset > network_size - 1
    "#{range.to_a[offset].to_s}/#{prefixlength}"
  end

  def broadcast(offset = 0)
    raise ArgumentError, 'offset out of bounds' if offset > network_size - 1
    "#{range.to_a[-1 - offset].to_s}/#{prefixlength}"
  end

  def increment(offset = 1)
    absolute_offset=self.offset + offset
    raise ArgumentError, 'increment out of bounds' if absolute_offset > network_size - 1
    "#{range.to_a[absolute_offset].to_s}/#{prefixlength}"
  end

  def offset
    range.to_a.index(address)
  end

  def split
    [ subnet(prefixlength + 1, 0), subnet(prefixlength + 1, 1) ]
  end

  def subnet(subnet_prefixlength, index)
    raise IPAddr::InvalidPrefixError, 'invalid subnet prefix' if subnet_prefixlength > unicast_prefixlength
    raise ArgumentError, 'subnet prefix too long' if subnet_prefixlength <= prefixlength
    subnet_size = 2 ** (unicast_prefixlength - subnet_prefixlength)
    raise ArgumentError, 'subnet index out of bounds' if (subnet_size * index) >= network_size
    "#{range.to_a[subnet_size * index]}/#{subnet_prefixlength}"
  end

  def supernet(supernet_prefixlength)
    raise IPAddr::InvalidPrefixError, 'invalid supernet prefix' if supernet_prefixlength > unicast_prefixlength
    raise ArgumentError, 'supernet prefix too short' if supernet_prefixlength < 0
    raise ArgumentError, 'supernet prefix too long' if supernet_prefixlength > prefixlength
    "#{cidr.mask(supernet_prefixlength)}/#{supernet_prefixlength}"
  end

  def to_s
    address.to_s
  end

private

  def range
    cidr.to_range
  end

  def unicast_prefixlength
    address.ipv4? ? 32 : 128
  end

  def unicast_netmask
    address.ipv4? ? '255.255.255.255' : 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
  end
end
