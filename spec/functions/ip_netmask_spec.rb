require 'spec_helper'

describe 'ip_netmask' do
    it { should run.with_params('10.0.0.1/24').and_return('255.255.255.0') }
    it { should run.with_params('10.0.0.1/255.255.255.0').and_return('255.255.255.0') }
    it { should run.with_params('10.0.0.1/255.255.255.256').and_raise_error(IPAddr::InvalidAddressError) }
    it { should run.with_params('10.0.0.1/33').and_raise_error(IPAddr::InvalidPrefixError) }
    it { should run.with_params('999.999.999.999/32').and_raise_error(IPAddr::InvalidAddressError) }
end
