require 'spec_helper'

describe 'ip_network' do
  it { is_expected.to run.with_params('10.0.0.1/24').and_return('10.0.0.0/24') }
  it { is_expected.to run.with_params('10.0.0.1/24', 2).and_return('10.0.0.2/24') }
  it { is_expected.to run.with_params('10.0.0.1/24', 255).and_return('10.0.0.255/24') }
  it { is_expected.to run.with_params('10.0.0.1/24', 256).and_raise_error(ArgumentError) }
  it { is_expected.to run.with_params('10.0.0.1/24', 999).and_raise_error(ArgumentError) }
  it { is_expected.to run.with_params('10.0.0.1/255.255.255.256').and_raise_error(IPAddr::InvalidAddressError) }
  it { is_expected.to run.with_params('10.0.0.1/33').and_raise_error(IPAddr::InvalidPrefixError) }
  it { is_expected.to run.with_params('999.999.999.999/32').and_raise_error(IPAddr::InvalidAddressError) }
  it { is_expected.to run.with_params('fd00::1/120').and_return('fd00::/120') }
  it { is_expected.to run.with_params('fd00::1/120', 2).and_return('fd00::2/120') }
  it { is_expected.to run.with_params('fd00::1/120', 255).and_return('fd00::ff/120') }
  it { is_expected.to run.with_params('fd00::1/120', 256).and_raise_error(ArgumentError) }
  it { is_expected.to run.with_params('fd00::1/129').and_raise_error(ArgumentError) }
end
