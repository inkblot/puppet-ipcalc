# ex: syntax=ruby si sw=2 ts=2 et
require 'ipaddr'

module PuppetX; end

class PuppetX::Ip
  attr_reader :cidr, :address, :prefixlength

  def initialize(cidr)
    @cidr = IPAddr.new(cidr)
    (addr, mask) = cidr.split(%r{/})
    @address = IPAddr.new(addr)
    if mask.nil?
      prefixlen = unicast_prefixlength
    elsif %r{\A\d+\z}.match?(mask)
      prefixlen = mask.to_i
    else
      m = IPAddr.new(mask)
      if m.family != @address.family
        raise ArgumentError, 'address family is not same'
      end
      prefixlen = m.to_i.to_s(2).count('1')
    end
    @prefixlength = prefixlen.to_i
  end

  def netmask
    IPAddr.new(unicast_netmask).mask(prefixlength).to_s
  end

  def network_size
    2**(unicast_prefixlength - prefixlength)
  end

  def network(offset = 0)
    raise ArgumentError, 'offset out of bounds' if (offset >= network_size) || (offset < 0)
    "#{IPAddr.new(cidr.to_i + offset, cidr.family)}/#{prefixlength}"
  end

  def broadcast(offset = 0)
    network(network_size - (offset + 1))
  end

  def increment(offset = 1)
    network(self.offset + offset)
  end

  def offset
    address.to_i - cidr.to_i
  end

  def range_size(range_cidr)
    other_address = IPAddr.new(range_cidr.split(%r{/})[0])
    raise ArgumentError, 'Both addresses must be in same family' if other_address.family != address.family

    # Range size should be inclusive of starting and ending addresses, hence +1
    range_subtraction = other_address.to_i - address.to_i
    range_subtraction.abs + 1
  end

  def split
    [ subnet(prefixlength + 1, 0), subnet(prefixlength + 1, 1) ]
  end

  def subnet(subnet_prefixlength, index)
    raise IPAddr::InvalidPrefixError, 'invalid subnet prefix' if subnet_prefixlength > unicast_prefixlength
    raise ArgumentError, 'subnet prefix too long' if subnet_prefixlength <= prefixlength
    subnet_size = 2**(unicast_prefixlength - subnet_prefixlength)
    raise ArgumentError, 'subnet index out of bounds' if (subnet_size * index) >= network_size
    "#{IPAddr.new(cidr.to_i + subnet_size * index, cidr.family)}/#{subnet_prefixlength}"
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

  def family
    case address.family
    when Socket::AF_INET
      'IPv4'
    when Socket::AF_INET6
      'IPv6'
    end
  end

  private

  def unicast_prefixlength
    case address.family
    when Socket::AF_INET
      32
    when Socket::AF_INET6
      128
    end
  end

  def unicast_netmask
    case address.family
    when Socket::AF_INET
      '255.255.255.255'
    when Socket::AF_INET6
      'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
    end
  end
end
