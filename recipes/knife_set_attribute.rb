#
# Cookbook Name:: tfchefint
# Recipe:: knife_set_attribute
# Author:: CollabNet, Inc. (<dev-devops@forge.collab.net>)
#
# Copyright 2014, CollabNet, Inc.
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

include_recipe "tfchefint::chefauth"

KNIFE_PLUGINS_DIR = ::File.join(node['tfchefint']['chefauth']['sf-admin-home'], '.chef', 'plugins', 'knife')

directory KNIFE_PLUGINS_DIR do
  owner "sf-admin"
  group "sf-admin"
  mode  00700
  recursive true
  action :create
end

git KNIFE_PLUGINS_DIR do
  repository 'https://github.com/amian84/knife-set-attribute.git'
  user 'sf-admin'
  group 'sf-admin'
  action :export
end
