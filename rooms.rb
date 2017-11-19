#!/usr/bin/env ruby

require 'byebug'

require './lib/input_processor.rb'
require './lib/schedule'
require './lib/usage'
require './lib/slot'

usage if ARGV.count != 1 

input = InputProcessor.new(ARGV[0])


