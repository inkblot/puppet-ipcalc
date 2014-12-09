ipcalc
======

## Description
This module provides puppet parser functions for performing IP address calculations in manifests.

## Setup

To use this module, install it on your module path. No further setup is
necessary to use any of its features.

## Conventions

This documentation refers to an IP address suffixed with a CIDR prefix length as an IP/CIDR.

## Usage

These are the functions available in this module:

### ```ip_address($cidr)```

ip_address takes an IP/CIDR and returns just the IP address.

### ```ip_prefixlen($cidr)```

ip_prefixlen takes an IP/CIDR and returns just the prefix length.

### ```ip_netmask($cidr)```

ip_netmask takes an IP/CIDR and returns the netmask which corresponds to its
prefix length.

### ```ip_network($cidr, $offset)```

ip_network takes two arguments. The first is an IP/CIDR which is required. The
second is an optional numerical offset which defaults to 0. The function
returns an IP/CIDR by computing the network address of the subnet containing
the supplied IP/CIDR and incrementing it by the offset. Given no offset, the
function returns the network address for the subnet containing the supplied
IP/CIDR. The maximum reasonable value for offset is one less than the size of
the subnet containing the supplied IP/CIDR but the function will probably
accept larger values.

### ```ip_broadcast($cidr, $offset)```

ip_broadcast takes two arguments. The first is an IP/CIDR which is required.
The second is an optional numerical offset which defaults to 0. The function
returns an IP/CIDR by computing the broadcast address of the subnet containing
the supplied IP/CIDR and decrementing it by the offset. Given no offset, the
function returns the broadcast address for the subnet containing the supplied
IP/CIDR. The maximum reasonable value for offset is one less than the size of
the subnet containing the supplied IP/CIDR but the function will probably
accept large values.

### ```ip_network_size($cidr)```

ip_network_size takes an IP/CIDR and returns the number of IP addresses
(including network and broadcast addresses) in the IP/CIDR's subnet.

### ```ip_offset($cidr)```

ip_offset takes an IP/CIDR and returns its numerical offset. The offset is the IP/CIDR's numerical distance from the beginning of its subnet at the network address.
