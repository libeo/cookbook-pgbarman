#
# Cookbook Name:: pgbarman
# Recipe:: user
#

user_account 'postgres' do
  action :create
  home '/var/lib/postgres'
end

ruby_block 'node-save-pubkey' do
  block do
    node.set['pgbarman']['postgres_pubkey'] = File.read('/var/lib/postgres/.ssh/id_rsa.pub')
    node.save
  end
end
