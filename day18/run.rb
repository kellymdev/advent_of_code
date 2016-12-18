require_relative 'tile.rb'

# number_of_rows = 3
# input = "..^^."

# number_of_rows = 10
# input = ".^^.^.^^^^"

# number_of_rows = 40
number_of_rows = 400000
input = "^..^^.^^^..^^.^...^^^^^....^.^..^^^.^.^.^^...^.^.^.^.^^.....^.^^.^.^.^.^.^.^^..^^^^^...^.....^....^."

tile = Tile.new(input, number_of_rows)
tile.run
