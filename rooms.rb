#!/usr/bin/env ruby

require 'byebug'

require './lib/input_processor.rb'
require './lib/schedule'
require './lib/usage'

usage if ARGV.count != 1 

input = InputProcessor.new(ARGV[0])
schedule = Schedule.new(input.slots)



