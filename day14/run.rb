require_relative 'generate_keys.rb'
require_relative 'super_keys.rb'

input = "abc"
# input = "ngcjuoqr"

# keys = GenerateKeys.new(input)
# keys.run

super_keys = SuperKeys.new(input)
super_keys.run
