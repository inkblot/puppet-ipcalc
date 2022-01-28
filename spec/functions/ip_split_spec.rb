require 'spec_helper'

describe 'ip_split' do
  it { is_expected.to run.with_params('10.0.0.1/23').and_return(['10.0.0.0/24', '10.0.1.0/24']) }
  it { is_expected.to run.with_params('10.0.0.1/255.255.254.0').and_return(['10.0.0.0/24', '10.0.1.0/24']) }
  it { is_expected.to run.with_params('10.0.0.1/255.255.255.255').and_raise_error(ArgumentError) }
  it { is_expected.to run.with_params('10.0.0.1/255.255.255.256').and_raise_error(IPAddr::InvalidAddressError) }
  it { is_expected.to run.with_params('10.0.0.1/33').and_raise_error(IPAddr::InvalidPrefixError) }
  it { is_expected.to run.with_params('999.999.999.999/32').and_raise_error(IPAddr::InvalidAddressError) }
  it { is_expected.to run.with_params('fd00::1/119').and_return(['fd00::/120', 'fd00::100/120']) }
end
