# frozen_string_literal: true

require 'spec_helper'

describe 'ip_range_size' do
  # please note that these tests are examples only
  # you will need to replace the params and return value
  # with your expectations
  it 'given adjacent IPv4 CIDR addresses, returns range size of 2' do
    is_expected.to run.with_params('192.168.1.1/32', '192.168.1.2/32').and_return(2)
  end
  it 'given adjacent IPv6 CIDR addresses, returns range size of 2' do
    is_expected.to run.with_params('2001:db8::8c28:c929:72db:49fd/64', '2001:db8::8c28:c929:72db:49fe/64').and_return(2)
  end
  it 'given adjacent IPv4 plain addresses, returns range size of 2' do
    is_expected.to run.with_params('192.168.1.1', '192.168.1.2').and_return(2)
  end
  it 'given adjacent IPv6 plain addresses, returns range size of 2' do
    is_expected.to run.with_params('2001:db8::8c28:c929:72db:49fd', '2001:db8::8c28:c929:72db:49fe').and_return(2)
  end
  it 'given adjacent IPv4 plain addresses in reversed order, returns range size of 2' do
    is_expected.to run.with_params('192.168.1.2', '192.168.1.1').and_return(2)
  end
  it 'given adjacent IPv6 plain addresses in reversed order, returns range size of 2' do
    is_expected.to run.with_params('2001:db8::8c28:c929:72db:49fe', '2001:db8::8c28:c929:72db:49fd').and_return(2)
  end
  it 'given IPv4 CIDR addresses with same offset in different /24 networks, returns range size of 257' do
    is_expected.to run.with_params('192.168.1.1/24', '192.168.2.1/24').and_return(257)
  end
  it 'given IPv6 CIDR addresses with same offset in different /56 networks, returns range size of 257' do
    is_expected.to run.with_params('2001:db8::8c28:c929:72db:49fe/56', '2001:db8::8c28:c929:72db:4afe/56').and_return(257)
  end
  it 'given IPv4 plain addresses in wildly different networks, returns correct range size' do
    is_expected.to run.with_params('10.0.57.1', '192.168.2.1').and_return(3_064_449_281)
  end
  it 'given IPv6 plain addresses in wildly different networks, returns correct range size' do
    is_expected.to run
      .with_params('2001:db8::8c28:c929:72db:49fe/64', 'fe80::9656:d028:8652:66b6/64')
      .and_return(295_747_758_515_978_496_797_848_443_371_614_837_945)
  end
  it 'given addresses in different families, raises an exception' do
    is_expected.to run
      .with_params('10.0.57.1', 'fe80::9656:d028:8652:66b6')
      .and_raise_error(ArgumentError, %r{addresses must be in same family})
    is_expected.to run
      .with_params('fe80::9656:d028:8652:66b6', '10.0.57.1')
      .and_raise_error(ArgumentError, %r{addresses must be in same family})
  end
end
