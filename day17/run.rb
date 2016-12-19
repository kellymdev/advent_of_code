require_relative 'access_vault.rb'
require_relative 'longest_route.rb'

input = "ihgpwlah"
# input = "kglvqrro"
# input = "ulqzkmiv"

# input = "gdjjyniy"

# vault = AccessVault.new(input)
# vault.run

steps = LongestRoute.new(input)
steps.run
