require_relative './spec_helper'
require_relative '../lib/schedule'

describe 'Schedule' do 

  it 'can build simple schedule with one event' do 
    input = InputProcessor.new('./spec/data/simple_event.txt')
    schedule = Schedule.new(input.slots)
    schedule.first_room.slots.should == input.slots
  end

  it 'can build schedule with a lunch break' do 
    input = InputProcessor.new('./spec/data/events_with_lunch.txt')
    schedule = Schedule.new(input.slots)
    lunch = schedule.lunch
    schedule.first_room.slots.should include(lunch)
  end

  it 'can distribute events between rooms' do
    input = InputProcessor.new('./spec/data/complex_table.txt') 
    schedule = Schedule.new(input.slots)
    schedule.first_room.slots.count.should be 8
    schedule.second_room.slots.count.should be 12
  end

end