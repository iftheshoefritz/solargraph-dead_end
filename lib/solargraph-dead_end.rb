# frozen_string_literal: true

require "solargraph"
require "solargraph/dead_end/version"
require "solargraph/dead_end/reporter"
require "dead_end"

Solargraph::Diagnostics.register "dead_end", Solargraph::DeadEnd::Reporter
