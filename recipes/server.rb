#
# Cookbook Name:: tfchefint
# Recipe:: server
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

include_recipe 'tfchefint::hooks'
include_recipe 'tfchefint::artifact_update_hook'
include_recipe 'tfchefint::chefauth'
include_recipe 'tfchefint::knife_set_attribute'
