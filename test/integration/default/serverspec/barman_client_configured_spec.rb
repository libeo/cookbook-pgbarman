require 'serverspec'
set :backend, :exec

describe 'Client is in server list' do
  describe command('barman list-server') do
    its(:stdout) { should match(/barman.local/) }
  end
end
