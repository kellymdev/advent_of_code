require_relative 'door.rb'
require_relative 'advanced_door.rb'

# input = "abc"
input = "ojvtpuvg"

# Part 1
# door = Door.new(input)
# door.run

# Part 2
advanced_door = AdvancedDoor.new(input)
advanced_door.run
