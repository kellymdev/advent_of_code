require_relative 'screen.rb'

input = <<-STRING
rect 3x2
rotate row y=0 by 4
STRING

screen = Screen.new(input)
screen.run
