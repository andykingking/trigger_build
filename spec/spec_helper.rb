require 'simplecov'
SimpleCov.start do
  minimum_coverage 100
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'trigger_build'
