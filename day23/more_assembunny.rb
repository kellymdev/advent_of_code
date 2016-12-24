class MoreAssembunny
  def initialize(instructions)
    @instructions = format_input(instructions)
    @current_instruction = 0
    @registers = {
      a: 12,
      b: 0,
      c: 0,
      d: 0
    }
  end

  def run
    while @current_instruction < @instructions.size
      instruction = @instructions[@current_instruction]
      print_instruction(instruction)

      perform_instruction(instruction)

      print_register_data
      @current_instruction += 1
    end

    print_register_data
  end

  private

  def print_instruction(instruction)
    puts instruction
  end

  def print_register_data
    puts "a: #{@registers[:a]}"
    puts "b: #{@registers[:b]}"
    puts "c: #{@registers[:c]}"
    puts "d: #{@registers[:d]}"
  end

  def perform_instruction(instruction)
    if instruction.include?("cpy")
      perform_copy(instruction)
    elsif instruction.include?("inc")
      perform_increase(instruction)
    elsif instruction.include?("dec")
      perform_decrease(instruction)
    elsif instruction.include?("jnz")
      perform_jump(instruction)
    elsif instruction.include?("tgl")
      perform_toggle(instruction)
    end
  end

  def perform_toggle(instruction)
    register = instruction[4..-1]
    register_value = @registers[register.to_sym]

    instruction_value = @current_instruction + register_value

    if (0..(@instructions.size - 1)).include?(instruction_value)
      instruction_to_change = @instructions[instruction_value]

      if instruction_to_change.include?("inc")
        @instructions[instruction_value].gsub!(/inc/, "dec")
      elsif instruction_to_change.include?("dec")
        @instructions[instruction_value].gsub!(/dec/, "inc")
      elsif instruction_to_change.include?("tgl")
        @instructions[instruction_value].gsub!(/tgl/, "inc")
      elsif instruction_to_change.include?("jnz")
        @instructions[instruction_value].gsub!(/jnz/, "cpy")
      elsif instruction_to_change.include?("cpy")
        @instructions[instruction_value].gsub!(/cpy/, "jnz")
      end
    end
  end

  def perform_copy(instruction)
    data = instruction[4..-1].split(" ")
    copy_from = data.first
    copy_to = data.last

    return unless register?(copy_to)

    if register?(copy_from)
      @registers[copy_to.to_sym] = @registers[copy_from.to_sym]
    else
      @registers[copy_to.to_sym] = copy_from.to_i
    end
  end

  def register?(char)
    ("a".."d").include?(char)
  end

  def perform_increase(instruction)
    register = instruction[4..-1]
    @registers[register.to_sym] += 1
  end

  def perform_decrease(instruction)
    register = instruction[4..-1]
    @registers[register.to_sym] -= 1
  end

  def perform_jump(instruction)
    data = instruction[4..-1].split(" ")
    register = data.first
    jump = data.last

    move = if register?(jump)
             @registers[jump.to_sym]
           else
             jump.to_i
           end

    return if register?(register) && @registers[register.to_sym].zero? || !register?(register) && register.to_i.zero?
    return if register?(jump) && @registers[jump.to_sym].zero?

    @current_instruction += (move - 1)
  end

  def format_input(instructions)
    instructions.split("\n")
  end
end
