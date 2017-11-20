#!/usr/bin/env ruby
# frozen_string_literal: true

require 'byebug'

require './lib/input_processor.rb'
require './lib/schedule'
require './lib/usage'

usage if ARGV.count != 1

input = InputProcessor.new(ARGV[0])

input.print_errors if input.errors?

schedule = Schedule.new(input.slots)

schedule.print
