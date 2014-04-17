require 'spec_helper'

describe 'Rails workstation' do

  it 'should successfully execute commands in Vagrant' do
    vagrant_exec('echo "Test"') == 'Test'
  end

  it 'should have Java installed' do
    expect(installed?('java')).to be_true
  end

  it 'should have Ruby installed' do
    expect(installed?('ruby')).to be_true
  end

  it 'should have PostgreSQL installed' do
    expect(installed?('psql')).to be_true
  end

  it 'should have Arcanist installed' do
    expect(installed?('arc')).to be_true
  end

end