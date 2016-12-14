require_relative 'generate_keys.rb'

# input = "abc"
input = "ngcjuoqr"

keys = GenerateKeys.new(input)
keys.run
