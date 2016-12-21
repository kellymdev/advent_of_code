require_relative 'radioisotope.rb'

# input = <<-STRING
# The first floor contains a hydrogen-compatible microchip, a lithium-compatible microchip.
# The second floor contains a hydrogen generator.
# The third floor contains a lithium generator.
# The fourth floor contains nothing relevant.
# STRING

input = <<-STRING
The first floor contains a thulium generator, a thulium-compatible microchip, a plutonium generator, a strontium generator.
The second floor contains a plutonium-compatible microchip, a strontium-compatible microchip.
The third floor contains a promethium generator, a promethium-compatible microchip, a ruthenium generator, a ruthenium-compatible microchip.
The fourth floor contains nothing relevant.
STRING

radioisotope = Radioisotope.new(input)
radioisotope.run
