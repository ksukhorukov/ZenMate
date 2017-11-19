# frozen_string_literal: true

require_relative './room'
require_relative './slot'

# Builds a schedule from the input data
class Schedule
  attr_reader :slots, :first_room, :second_room, :lunch

  def initialize(slots)
    @slots = slots
    @lunch = Slot.new('Lunch', 60, '12:00PM')
    @first_room = Room.new
    @second_room = Room.new
    build
  end

  def build
    sort_slots
    distribute_slots(@first_room)
    distribute_slots(@second_room)
  end

  def sort_slots
    @slots = slots.sort_by { |slot| slot.duration * -1 }
  end

  def distribute_slots(room)
    while slots?
      slot = fetch_slot
      if out_of_time(room, slot)
        put_back(slot)
        break
      elsif overlaps_with_lunch(room, slot)
        mark_lunch(room)
      end
      add_slot_to_room(room, slot)
    end
  end

  def slots?
    slots.count.positive?
  end

  def fetch_slot
    @slots.shift
  end

  def put_back(slot)
    @slots.unshift slot
  end

  def mark_lunch(room)
    room.add_slot(lunch)
    room.timeline = 13 * 60
  end

  def add_slot_to_room(room, slot)
    slot.time = convert_minutes_to_time(room.timeline)
    room.add_slot(slot)
    room.timeline += slot.duration
  end

  def overlaps_with_lunch(room, slot)
    timeline = room.timeline
    duration = slot.duration
    timeline <= 12 * 60 && timeline + duration > 12 * 60
  end

  def out_of_time(room, slot)
    timeline = room.timeline
    duration = slot.duration
    timeline + duration > 17 * 60
  end

  def convert_minutes_to_time(n)
    hour = n.div 60
    minutes = n % 60
    minutes = '0' + minutes.to_s if minutes < 10
    meridian = hour >= 12 ? 'PM' : 'AM'
    hour = case hour
           when 0, 12
             12
           when 13..23
             hour - 12
           else
             hour < 10 ? '0' + hour.to_s : hour
          end
    "#{hour}:#{minutes}#{meridian}"
  end

  def print
    puts 'Room 1:'
    print_room(first_room)
    puts 'Room 2:'
    print_room(second_room)
  end

  def print_room(room)
    room.slots.each { |slot| puts "#{slot.time} #{slot.title}" }
  end
end
