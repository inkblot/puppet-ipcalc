require 'spec_helper'

describe 'ip_supernet' do
  it { is_expected.to run.with_params('10.0.0.1/23', 22).and_return('10.0.0.0/22') }
  it { is_expected.to run.with_params('10.0.0.1/23', 24).and_raise_error(ArgumentError) }
  it { is_expected.to run.with_params('10.0.0.1/23', -1).and_raise_error(ArgumentError) }
  it { is_expected.to run.with_params('10.0.0.1/255.255.254.0', 22).and_return('10.0.0.0/22') }
  it { is_expected.to run.with_params('10.0.0.1/255.255.254.0', 24).and_raise_error(ArgumentError) }
  it { is_expected.to run.with_params('10.0.0.1/255.255.255.256', 32).and_raise_error(IPAddr::InvalidAddressError) }
  it { is_expected.to run.with_params('10.0.0.1/33', 32).and_raise_error(IPAddr::InvalidPrefixError) }
  it { is_expected.to run.with_params('999.999.999.999/32', 32).and_raise_error(IPAddr::InvalidAddressError) }
  it { is_expected.to run.with_params('fd00::1/119', 118).and_return('fd00::/118') }
  it { is_expected.to run.with_params('fd00::1/119', 120).and_raise_error(ArgumentError) }
  it { is_expected.to run.with_params('fd00::1/119', -1).and_raise_error(ArgumentError) }
  it { is_expected.to run.with_params('fd00::1/129', 128).and_raise_error(IPAddr::InvalidPrefixError) }
end
