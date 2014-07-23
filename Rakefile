require 'rake/testtask'
require 'bundler/setup'

task default: [:test]

task test: ['test:unit']

namespace(:test) do
  Rake::TestTask.new(:unit) do |t|
    t.pattern = "test/unit/*_test.rb"
  end
end
