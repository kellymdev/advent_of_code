require_relative 'ip_address.rb'

input = <<-STRING
5-8
0-2
4-7
STRING

minimum = 0
maximum = 9

ip = IpAddress.new(input, minimum, maximum)
ip.run
