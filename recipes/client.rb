#
# Cookbook Name:: pgbarman
# Recipe:: client
#

user_account 'postgres' do
  action :create
  home '/var/lib/postgresql'
end

ruby_block 'node-save-pubkey' do
  block do
    node.set['pgbarman']['postgres_pubkey'] = File.read('/var/lib/postgresql/.ssh/id_rsa.pub')
    node.save
  end
end
