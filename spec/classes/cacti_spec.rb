require 'spec_helper'

describe 'cacti' do
  on_supported_os({
    :hardwaremodels => ['x86_64'],
    :supported_os   => [
      {
        "operatingsystem" => "RedHat",
        "operatingsystemrelease" => [
          "7",
        ]
      }
    ],
  }).each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        it { should compile.with_all_deps }
        it { should contain_class('cacti::params') }
        it { should contain_class('cacti::install').that_comes_before('cacti::mysql') }
        it { should contain_class('cacti::mysql').that_comes_before('cacti::config') }
        it { should contain_class('cacti::config') }
        it { should contain_class('cacti::service') }
      end
    end
end
