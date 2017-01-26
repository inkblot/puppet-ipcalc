require 'spec_helper'

describe 'ip_network' do
    it { should run.with_params('10.0.0.1/24').and_return('10.0.0.0/24') }
    it { should run.with_params('10.0.0.1/24',2).and_return('10.0.0.2/24') }
    it { should run.with_params('10.0.0.1/24',999).and_raise_error(ArgumentError) }
    it { should run.with_params('10.0.0.1/24',999).and_raise_error(ArgumentError) }
    it { should run.with_params('10.0.0.1/255.255.255.256').and_raise_error(IPAddr::InvalidAddressError) }
    it { should run.with_params('10.0.0.1/33').and_raise_error(IPAddr::InvalidPrefixError) }
    it { should run.with_params('999.999.999.999/32').and_raise_error(IPAddr::InvalidAddressError) }
end

