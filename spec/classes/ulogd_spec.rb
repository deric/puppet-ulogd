# frozen_string_literal: true

require 'spec_helper'

describe 'ulogd' do
  _, os_facts = on_supported_os.first
  let(:facts) { os_facts }

  it { is_expected.to compile.with_all_deps }
  it { is_expected.to contain_package('ulogd2').with_ensure(%r{present|installed}) }
  it { is_expected.to contain_service('ulogd2').with_ensure(%r{running}) }
  it { is_expected.to contain_file('/etc/ulogd.conf').with_content(%r{^\[global\]\nlogfile=syslog$}) }

  context 'with plugins' do
    let(:params) do
      {
        plugins: ['ulogd_inppkt_NFLOG.so']
      }
    end

    it { is_expected.to contain_file('/etc/ulogd.conf').with_content(%r{^plugin="/usr/lib/x86_64-linux-gnu/ulogd/ulogd_inppkt_NFLOG.so"$}) }
  end
end
