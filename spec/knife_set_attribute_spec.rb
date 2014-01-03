require 'spec_helper'

SF_ADMIN_HOME = '/opt/collabnet/teamforge/var/home/sf-admin'

describe 'tfchefint::knife_set_attribute' do
  let (:chef_run) do
    ChefSpec::Runner.new ::CENTOS_OPTS do |node|
      node.set['tfchefint']['chefauth']['sf-admin-home'] = SF_ADMIN_HOME
    end.converge('tfchefint::knife_set_attribute')
  end

  knife_plugin_dir = ::File.join(SF_ADMIN_HOME, '.chef', 'plugins', 'knife')

  it 'should create knife plugins directory' do
    expect(chef_run).to create_directory(knife_plugin_dir)
    expect(chef_run).to_not create_directory('/non-existing-directory')
  end

  it 'should create knife plugins directory with attribtes' do
    expect(chef_run).to create_directory(knife_plugin_dir).with(
      owner: "sf-admin",
      group: "sf-admin",
      mode:  00700,
      recursive: true,
    )

    expect(chef_run).to_not create_directory(knife_plugin_dir).with(
      owner: "admin",
      group: "admin",
      mode:  00655,
      recursive: false,
    )
  end

  it 'should export git repository' do
    expect(chef_run).to export_git(knife_plugin_dir)
    expect(chef_run).to_not export_git('/non-existin-directory')
  end

  it 'should export git repository with attributes' do
    expect(chef_run).to export_git(knife_plugin_dir).with(
      repository: 'https://github.com/amian84/knife-set-attribute.git',
      reference: 'HEAD',
    )

    expect(chef_run).to_not sync_git(knife_plugin_dir).with(
      repository: 'git://github.com/no-scripts/scripts.git',
      reference: 'tag',
    )
  end
end
