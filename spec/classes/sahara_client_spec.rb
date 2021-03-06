#
# Unit tests for sahara::client
#
require 'spec_helper'

describe 'sahara::client' do

  shared_examples_for 'sahara client' do

    context 'with default parameters' do
      it { should contain_package('python-saharaclient').with_ensure('present') }
    end

    context 'with package_ensure parameter provided' do
      let :params do
        { :package_ensure => false }
      end
      it { should contain_package('python-saharaclient').with_ensure('false') }
    end

  end

  context 'on Debian platforms' do
    let :facts do
      {
        :osfamily => 'Debian',
        :operatingsystem => 'Debian'
      }
    end

    it_configures 'sahara client'
  end

  context 'on RedHat platforms' do
    let :facts do
      { :osfamily => 'RedHat' }
    end

    it_configures 'sahara client'
  end
end
