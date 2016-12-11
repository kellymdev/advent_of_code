require_relative 'radioisotope.rb'

input = <<-STRING
The first floor contains a hydrogen-compatible microchip, a lithium-compatible microchip.
The second floor contains a hydrogen generator.
The third floor contains a lithium generator.
The fourth floor contains nothing relevant.
STRING

radioisotope = Radioisotope.new(input)
radioisotope.run
