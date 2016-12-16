require_relative 'generate_dragon.rb'

# input = "10000"
# disk_length = 20
input = "11101000110010100"
# disk_length = 272
disk_length = 35651584

dragon = GenerateDragon.new(input, disk_length)
dragon.run
