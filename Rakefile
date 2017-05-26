require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

desc 'Source code metrics analysis'
RuboCop::RakeTask.new(:metrics) do |task|
  task.fail_on_error = true
end

desc 'Run unit tests'
RSpec::Core::RakeTask.new(:spec)

task default: %w[metrics spec]
