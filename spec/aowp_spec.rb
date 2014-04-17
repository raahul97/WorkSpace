require 'spec_helper'

describe 'AOWP workstation' do

  it 'should successfully execute commands in Vagrant' do
    vagrant_exec('echo "Test"') == 'Test'
  end

  it 'should have Java installed' do
    expect(installed?('java')).to be_true
  end

  it 'should have PHP installed' do
    expect(installed?('php')).to be_true
  end

  it 'should have Arcanist installed' do
    expect(installed?('arc')).to be_true
  end

  it 'should have compass gem installed' do
    expect(installed?('compass')).to be_true
  end

  describe 'Node.JS and AOWP environment' do
    it 'should have Node.JS and NPM installed' do
      expect(installed?('node')).to be_true
      expect(installed?('npm')).to be_true
    end

    it 'should have AOWP Node.JS stack installed' do
      expect(installed?('yo')).to be_true
      expect(installed?('grunt')).to be_true
      expect(installed?('bower')).to be_true
    end
  end

end
