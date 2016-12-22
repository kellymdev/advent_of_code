class UnscramblePassword
  def initialize(password, instructions)
    @password = password
    @instructions = format_instructions(instructions)
  end

  def run
    @instructions.each do |instruction|
      perform_instruction(instruction)
    end

    print_password
  end

  private

  def perform_instruction(instruction)
    if instruction.include?("swap position")
      swap_position(instruction)
    elsif instruction.include?("swap letter")
      swap_letter(instruction)
    elsif instruction.include?("rotate left")
      rotate_left(instruction)
    elsif instruction.include?("rotate right")
      rotate_right(instruction)
    elsif instruction.include?("rotate based on position")
      rotate_based_on_position(instruction)
    elsif instruction.include?("reverse positions")
      reverse_positions(instruction)
    elsif instruction.include?("move position")
      move_positions(instruction)
    end
  end

  def move_positions(instruction)
    values = /move position (\d) to position (\d)/.match(instruction)

    index1 = values[1].to_i
    index2 = values[2].to_i

    letter2 = @password[index2]

    @password.delete!(letter2)

    @password.insert(index1, letter2)
  end

  def reverse_positions(instruction)
    values = /reverse positions (\d) through (\d)/.match(instruction)

    index1 = values[1].to_i
    index2 = values[2].to_i

    substring = @password[index1..index2]

    @password[index1..index2] = substring.reverse
  end

  def rotate_based_on_position(instruction)
    value = /rotate based on position of letter ([a-z])/.match(instruction)

    letter = value[1]
    index = @password.index(letter)

    strings = create_strings_for_each_position(@password)

    puts "Original: #{strings}"

    rotated = strings.map do |string|
      original_rotate_based_on_position("rotate based on position of letter #{letter}", string)
    end

    puts "Rotated: #{rotated}"

    unrotated = strings[0]

    index_of_rotated = rotated.rindex(unrotated)

    @password = strings[index_of_rotated]
  end

  def create_strings_for_each_position(string)
    strings = []

    @password.length.times do |index|
      new_string = original_rotate_right("rotate right #{index} steps", string)

      strings << new_string
    end

    strings
  end

  def original_rotate_based_on_position(instruction, string)
    value = /rotate based on position of letter ([a-z])/.match(instruction)

    letter = value[1]
    index = string.index(letter)

    new_string = string

    if index >= 4
      (index + 2).times { new_string = original_rotate_right("rotate right 1 step", new_string) }
    else
      (index + 1).times {  new_string = original_rotate_right("rotate right 1 step", new_string) }
    end

    new_string
  end

  def original_rotate_right(instruction, string)
    value = /rotate right (\d) step/.match(instruction)

    array = string.chars
    string_to_join = ""

    value[1].to_i.times { string_to_join += array.pop }

    string_to_join.reverse + array.join
  end

  # this is rotating left to counteract the rotate right action of the scrambled password
  def rotate_right(instruction)
    value = /rotate right (\d) step/.match(instruction)

    array = @password.chars
    string_to_join = ""

    value[1].to_i.times { string_to_join += array.shift }

    @password = array.join + string_to_join
  end

  # this is rotating right to counteract the rotate left action of the scrambled password
  def rotate_left(instruction)
    value = /rotate left (\d) step/.match(instruction)

    array = @password.chars
    string_to_join = ""

    value[1].to_i.times { string_to_join += array.pop }

    @password = string_to_join.reverse + array.join
  end

  def swap_letter(instruction)
    values = /swap letter ([a-z]) with letter ([a-z])/.match(instruction)
    letter1 = values[1]
    letter2 = values[2]

    index1 = @password.index(letter1)
    index2 = @password.index(letter2)

    @password[index1] = letter2
    @password[index2] = letter1
  end

  def swap_position(instruction)
    values = /swap position (\d) with position (\d)/.match(instruction)
    index1 = values[1].to_i
    index2 = values[2].to_i

    letter1 = @password[index1]
    letter2 = @password[index2]

    @password[index1] = letter2
    @password[index2] = letter1
  end

  def print_password
    puts @password
  end

  def format_instructions(instructions)
    instructions.split("\n").reverse
  end
end
