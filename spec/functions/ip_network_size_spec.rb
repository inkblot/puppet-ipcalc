require 'spec_helper'

describe 'ip_network_size' do
  it { is_expected.to run.with_params('10.0.0.1/24').and_return(256) }
  it { is_expected.to run.with_params('10.0.0.1/255.255.255.0').and_return(256) }
  it { is_expected.to run.with_params('10.0.0.1/255.255.255.256').and_raise_error(IPAddr::InvalidAddressError) }
  it { is_expected.to run.with_params('10.0.0.1/33').and_raise_error(IPAddr::InvalidPrefixError) }
  it { is_expected.to run.with_params('999.999.999.999/32').and_raise_error(IPAddr::InvalidAddressError) }
  it { is_expected.to run.with_params('fd00::1/120').and_return(256) }
  it { is_expected.to run.with_params('fd00::1/129').and_raise_error(IPAddr::InvalidPrefixError) }
end
