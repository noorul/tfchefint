require 'spec_helper'

HOOKS_JAR_FILE_PATH = "/opt/collabnet/teamforge/var/events/hooks.jar"

describe 'tfchefint::hooks' do
  let (:chef_run) {
    ChefSpec::Runner.new.converge('tfchefint::hooks')
  }

  it 'should create hooks.jar file' do
    expect(chef_run).to create_cookbook_file(HOOKS_JAR_FILE_PATH)
    expect(chef_run).to_not create_cookbook_file('/non-existin-file')
  end

  it 'should create file with attribtes' do
    expect(chef_run).to create_cookbook_file(HOOKS_JAR_FILE_PATH).with(
      owner: "sf-admin",
      group: "sf-admin",
      mode:  00644,
    )

    expect(chef_run).to_not create_cookbook_file(HOOKS_JAR_FILE_PATH).with(
      owner: "admin",
      group: "admin",
      mode:  00645,
    )
  end
end
