$stdout.sync = true
$stderr.sync = true

GC::Profiler.enable

require './app'

run AppController
