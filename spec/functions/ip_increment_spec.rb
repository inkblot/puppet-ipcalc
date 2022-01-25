require 'spec_helper'

describe 'ip_increment' do
  it { is_expected.to run.with_params('10.0.0.254/23', '2').and_return('10.0.1.0/23') }
  it { is_expected.to run.with_params('10.0.0.1/24').and_return('10.0.0.2/24') }
  it { is_expected.to run.with_params('10.0.0.255/24').and_raise_error(ArgumentError) }
  it { is_expected.to run.with_params('fd00::fe/119', '2').and_return('fd00::100/119') }
  it { is_expected.to run.with_params('fd00::1/120').and_return('fd00::2/120') }
  it { is_expected.to run.with_params('fd00::ff/120').and_raise_error(ArgumentError) }
  it { is_expected.to run.with_params('2600:3c00::f03c:91ff:fe96:432a/64', 5).and_return('2600:3c00::f03c:91ff:fe96:432f/64') }
end
