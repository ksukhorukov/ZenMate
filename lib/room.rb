# frozen_string_literal: true

# Describes room
class Room
  attr_reader :slots, :duration
  attr_accessor :timeline

  def initialize
    @slots = []
    @duration = 0
    @timeline = 9 * 60
  end

  def add_slot(slot)
    @slots.push slot
    @duration += slot.duration
  end
end
