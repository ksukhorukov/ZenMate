# frozen_string_literal: true

# Slot describes an element in a schedule
class Slot
  attr_reader :title, :duration
  attr_accessor :time

  def initialize(title, duration, time = '')
    @title = title
    @duration = duration
    @time = time
  end
end
