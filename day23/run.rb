require_relative 'more_assembunny.rb'

# input = <<-STRING
# cpy 2 a
# tgl a
# tgl a
# tgl a
# cpy 1 a
# dec a
# dec a
# STRING

input = <<-STRING
cpy a b
dec b
cpy a d
cpy 0 a
cpy b c
inc a
dec c
jnz c -2
dec d
jnz d -5
dec b
cpy b c
cpy c d
dec d
inc c
jnz d -2
tgl c
cpy -16 c
jnz 1 c
cpy 71 c
jnz 72 d
inc a
inc d
jnz d -2
inc c
jnz c -5
STRING

bunny = MoreAssembunny.new(input)
bunny.run
