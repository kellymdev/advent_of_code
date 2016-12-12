class Assembunny
  def initialize(instructions)
    @instructions = format_input(instructions)
    @current_instruction = 0
    @registers = {
      a: 0,
      b: 0,
      c: 0,
      d: 0
    }
  end

  def run
    while @current_instruction < @instructions.size
      instruction = @instructions[@current_instruction]
      perform_instruction(instruction)
      @current_instruction += 1
    end

    print_register_data
  end

  private

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
    end
  end

  def perform_copy(instruction)
    data = instruction[4..-1].split(" ")
    copy_from = data.first
    copy_to = data.last

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
    jump = data.last.to_i

    return if register?(register) && @registers[register.to_sym].zero?

    @current_instruction += (jump - 1)
  end

  def format_input(instructions)
    instructions.split("\n")
  end
end
