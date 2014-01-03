#
# Cookbook Name:: tfchefint
# Recipe:: chefauth
# Authors:: Julian C. Dunn (<jdunn@opscode.com>)
#           CollabNet, Inc. (<dev-devops@forge.collab.net>)
#
# Copyright 2014, CollabNet, Inc.
# Copyright 2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

sf_admin_home = node['tfchefint']['chefauth']['sf-admin-home']

execute "generate-sfadmin-keypair" do
  command "ssh-keygen -q -f #{sf_admin_home}/.ssh/id_rsa -N ''"
  user 'sf-admin'
  not_if { ::File.exists?("#{sf_admin_home}/.ssh/id_rsa") }
  action :run
  notifies :write, "log[remind-user-to-put-public-key-in-databag]"
end

log "remind-user-to-put-public-key-in-databag" do
  message "Generated keypair for sf-admin. Remember to put the public key in the databag item users::sf-admin!"
  action :nothing
end

dotchef = ::File.join(sf_admin_home, '.chef')

directory dotchef do
  owner "sf-admin"
  group "sf-admin"
  mode  00700
  action :create
end

template "#{dotchef}/knife.rb" do
  source "knife.rb.erb"
  owner "sf-admin"
  group "sf-admin"
  mode  00600
  action :create
end

log "remind-user-to-put-pem-in-dotchef" do
  message "Remember to put sf-admin.pem into #{dotchef}"
  not_if { ::File.exists?(::File.join(dotchef, 'sf-admin.pem')) }
end
