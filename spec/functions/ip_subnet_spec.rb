require 'spec_helper'

describe 'ip_subnet' do
    it { should run.with_params('10.0.0.1/23',24,1).and_return("10.0.1.0/24") }
    it { should run.with_params('10.0.0.1/255.255.254.0',24,0).and_return("10.0.0.0/24") }
    it { should run.with_params('10.0.0.1/23',24,2).and_raise_error(ArgumentError) }
    it { should run.with_params('10.0.0.1/23',23,1).and_raise_error(ArgumentError) }
    it { should run.with_params('10.0.0.1/23',22,1).and_raise_error(ArgumentError) }
    it { should run.with_params('10.0.0.1/23',24,2).and_raise_error(ArgumentError) }
    it { should run.with_params('10.0.0.1/32',33,1).and_raise_error(IPAddr::InvalidPrefixError) }
    it { should run.with_params('10.0.0.1/255.255.255.256',32,1).and_raise_error(IPAddr::InvalidAddressError) }
    it { should run.with_params('10.0.0.1/33',32,1).and_raise_error(IPAddr::InvalidPrefixError) }
    it { should run.with_params('999.999.999.999/32',32,1).and_raise_error(IPAddr::InvalidAddressError) }
end
