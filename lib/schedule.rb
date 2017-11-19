require 'byebug'

class Schedule
  attr_reader :slots, :first_room, :second_room

  def initialize(slots)
    @slots = slots
    @first_room = []
    @second_room = []
    build
  end

  def build
    sort_slots
  end

  def sort_slots
    @slots = slots.sort_by { |slot| slot.duration * -1 }
  end

  def print
  end
end