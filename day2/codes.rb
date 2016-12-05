class Codes
  def initialize(instruction)
    @instruction = instruction
    @keypad = [["1", "4", "7"],["2", "5", "8"], ["3", "6", "9"]]
    @code = ""
    @position_x = 1
    @position_y = 1
  end

  def run
    @instruction.each do |step|
      letters = step.chars
      count = letters.length

      letters.each_with_index do |letter, index|
        determine_position(letter)

        if index == count - 1
          @code += determine_number(@position_x, @position_y)
        end
      end
    end
  end

  def print_code
    puts "Code: #{@code}"
  end

  private

  def determine_number(x, y)
    @keypad[x][y]
  end

  def determine_position(letter)
    case letter
      when "U"
        @position_y -= 1 if @position_y > 0
      when "D"
        @position_y += 1 if @position_y < 2
      when "L"
        @position_x -= 1 if @position_x > 0
      when "R"
        @position_x += 1 if @position_x < 2
    end
  end
end
