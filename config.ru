$stdout.sync = true
$stderr.sync = true

GC::Profiler.enable

require_relative "skuld"

run Skuld
