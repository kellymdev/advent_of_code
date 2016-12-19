require_relative 'exchange_presents.rb'
require_relative 'exchange_presents_in_circle.rb'

input = 5
# input = 3012210

# presents = ExchangePresents.new(input)
# presents.run

circle = ExchangePresentsInCircle.new(input)
circle.run
