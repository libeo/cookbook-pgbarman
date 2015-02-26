require 'serverspec'
set :backend, :exec

describe 'Executable installed' do
  describe command('which barman') do
    its(:exit_status) { should eq 0 }
  end
end
