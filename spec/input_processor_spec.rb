require_relative './spec_helper'
require_relative '../lib/input_processor'
require 'byebug'

describe 'InputProcessor' do 

  it 'notifies that input file does not exist when incorrect filename givven' do 
    input = InputProcessor.new('non_existing_file.txt')
    input.errors.should include(/No such file or directory/)
  end

  it 'notifies that input data is incorrect when data cannot be parsed' do 
    input = InputProcessor.new('./spec/data/incorrect_event.txt')
    input.errors.should include(/Invalid input/)
  end

  it 'notifies that schedule cannot be build when overall time is out of boundaries' do
    input = InputProcessor.new('./spec/data/out_of_time.txt')
    input.errors.should include(/Out of time/)
  end

  it 'successfully parses data and builds schedule when everything is fine' do 
    input = InputProcessor.new('./spec/data/correct_data.txt')
    input.errors?.should be false
    input.slots.count.should be 1
    input.overall.should be 60
  end

end