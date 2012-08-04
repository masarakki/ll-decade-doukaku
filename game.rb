#!/usr/bin/env ruby

require_relative 'decade'

puts Game.new(ARGF.readlines).str
