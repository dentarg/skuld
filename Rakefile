require 'rake/testtask'
require 'bundler/setup'

task default: [:test]

task test: ['test:unit', 'test:integration']

namespace(:test) do
  Rake::TestTask.new(:unit) do |t|
    t.pattern = "test/unit/*_test.rb"
  end

  Rake::TestTask.new(:integration) do |t|
    t.pattern = "test/integration/*_test.rb"
  end
end
