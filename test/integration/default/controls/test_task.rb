# frozen_string_literal: true

include_controls 'inspec-aws'
require './test/library/common'

tfstate = StateFileReader.new
task_id = tfstate.read['outputs']['task_definition']['value']['task']['family'].to_s

control 'default' do
  describe aws_ecs_task_definition(task_definition: task_id) do
    it { should exist }
  end
end
