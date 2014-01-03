TeamForge-Chef Integration Cookbook
===================================

Installs scripts and associated automation needed to get CollabNet TeamForge and Chef integrated.

Requirements
============

CollabNet TeamForge Server plus some nodes to deploy software to.

Attributes
==========

See `attributes/default.rb` for default values.

chefauth
--------

* `node['tfchefint']['chefauth']['sf-admin-home']` - the default install location of CollabNet TeamForge and hence the home directory of the 'sf-admin' user
* `node['tfchefint']['chefauth']['chef-server-url']` - the Chef server to contact in the asynchronous callback scripts

Recipes
=======

default
-------

Does nothing.

client
------

Convenient recipe that includes `user` and `sudoers` recipes to make the integration work. 'client' runs on each application server;

server
------

Convenient recipe that includes relevant individual recipes to make the integration work. 'server' runs on the TeamForge server itself and installs the asynchronous hook and authentication components (e.g. Chef configurations)

artifact_update_hook
--------------------

Installs the artifact update hook script, which is a template, into the asynchronous hooks directory.

chefauth
--------

Sets up the TeamForge server so that Knife, running under the 'sf-admin' (TeamForge) user ID, can authenticate to the Chef server as a client.

We assume that a user called 'sf-admin' has been created ahead of time on the Chef server, and that the 'sf-admin.pem' can be placed manually on the TeamForge server.

hooks
-----

Installs the Java-to-arbitrary-language bridge, `hooks.jar`, on the TeamForge server, so that the artifact_update Ruby script can run.

While `hooks.jar` is not officially supported by CollabNet, some directions on its design can be found on CollabNet's blog: http://blogs.collab.net/teamforge/custom-workflow-in-teamforge-a-guide-to-iaf-event-handlers

A version of `hooks.jar` that supports passing flex field data as environment variables is included. It was retrieved from here: http://forums.open.collab.net/ds/viewMessage.do?dsForumId=738&dsMessageId=486169

sudoers
-------

Sets up sudoers on client machines so that the 'sf-admin' user can run Chef client as root (or signal the currently-running daemon to restart).

Note: The sf-admin user needs to be able to run the commands in this recipe without requiring a TTY. You can set this up in your main sudoers file if necessary (e.g. using Opscode's sudo cookbook), or if you're running OpenSSH >= 5.9, the `RequestTTY` option can be used in the host's ssh_options to always force the creation of a TTY.

user
----

Sets up a user called `sf-admin` on client machines.

License and Author
==================

* Authors:: Julian C. Dunn (<jdunn@opscode.com>)
            CollabNet, Inc. (<dev-devops@forge.collab.net>)
* Copyright:: 2014, CollabNet, Inc.
* Copyright:: 2013, Opscode, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
