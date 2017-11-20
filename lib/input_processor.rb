# frozen_string_literal: true

require_relative './slot'
# Validates and prepares an input
class InputProcessor
  attr_reader :slots, :data, :overall, :errors

  def initialize(file_name)

    @errors = []

    begin
      @data = IO.readlines(file_name)
    rescue StandardError => e
      error(e.message)
    end

    return if errors?

    @slots = []
    @overall = 0

    process_input
    check_overall_duration
  end

  def error(message)
    @errors.push "Error! #{message}"
  end

  def errors?
    !errors.empty?
  end

  def process_input
    data.each do |str|
      title, duration = parse(str)
      return if errors?
      add_slot(title, duration)
    end
  end

  def parse(str)
    parsed_data = str.match(/^(.*)\s([0-9]+)min$/)
    if parsed_data.nil?
      error("Invalid input: '#{str.chomp}'") 
      return
    else
      [parsed_data[1], parsed_data[2].to_i]
    end
  end

  def add_slot(title, duration)
    slots.push Slot.new(title, duration)
    @overall += duration
  end

  def check_overall_duration
    error('No way to build schedule. Out of time.') if overall > 7 * 60 * 2
  end

  def print_errors
    errors.each { |error| puts error }
    exit
  end
end
