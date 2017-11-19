# frozen_string_literal: true

require_relative './slot'
# Validates and prepares an input
class InputProcessor
  attr_reader :slots, :data, :overall

  def initialize(file_name)
    begin
      @data = IO.readlines(file_name)
    rescue StandardError => e
      error(e.message)
    end

    @slots = []
    @overall = 0

    process_input
    check_overall_duration
  end

  def error(message)
    puts "Error! #{message}"
    exit
  end

  def process_input
    data.each do |str|
      title, duration = parse(str)
      add_slot(title, duration)
    end
  end

  def parse(str)
    parsed_data = str.match(/^(.*)\s([0-9]+)min$/)
    error("Invalid input: '#{str.chomp}'") if parsed_data.nil?
    [parsed_data[1], parsed_data[2].to_i]
  end

  def add_slot(title, duration)
    slots.push Slot.new(title, duration)
    @overall += duration
  end

  def check_overall_duration
    error('No way to build schedule. Out of time.') if overall > 7 * 60 * 2
  end
end
