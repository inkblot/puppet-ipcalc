require 'spec_helper'

describe 'ip_supernet' do
    it { should run.with_params('10.0.0.1/23',22).and_return("10.0.0.0/22") }
    it { should run.with_params('10.0.0.1/23',24).and_raise_error(ArgumentError) }
    it { should run.with_params('10.0.0.1/23',-1).and_raise_error(ArgumentError) }
    it { should run.with_params('10.0.0.1/255.255.254.0',22).and_return("10.0.0.0/22") }
    it { should run.with_params('10.0.0.1/255.255.254.0',24).and_raise_error(ArgumentError) }
    it { should run.with_params('10.0.0.1/255.255.255.256',32).and_raise_error(IPAddr::InvalidAddressError) }
    it { should run.with_params('10.0.0.1/33',32).and_raise_error(IPAddr::InvalidPrefixError) }
    it { should run.with_params('999.999.999.999/32',32).and_raise_error(IPAddr::InvalidAddressError) }
end
