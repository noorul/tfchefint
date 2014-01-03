require 'spec_helper'

CTF_HOOKS_ASYNC_DIR = '/opt/collabnet/teamforge/hooks/asynchronous'

describe 'tfchefint::artifact_update_hook' do
  let (:chef_run) {
    ChefSpec::Runner.new.converge('tfchefint::artifact_update_hook')
  }

  it 'should create hooks asynchronous directory' do
    expect(chef_run).to create_directory(CTF_HOOKS_ASYNC_DIR)
    expect(chef_run).to_not create_directory('/non-existing-directory')
  end

  it 'should create hooks asynchronous directory with attribtes' do
    expect(chef_run).to create_directory(CTF_HOOKS_ASYNC_DIR).with(
      owner: "sf-admin",
      group: "sf-admin",
      mode:  00755,
      recursive: true,
    )

    expect(chef_run).to_not create_directory(CTF_HOOKS_ASYNC_DIR).with(
      owner: "admin",
      group: "admin",
      mode:  00655,
      recursive: false,
    )
  end
end
