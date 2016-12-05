class AdvancedCodes
  def initialize(instruction)
    @instruction = instruction
    @keypad = [["x", "x", "5", "x", "x"], ["x", "2", "6", "A", "x"], ["1", "3", "7", "B", "D"], ["x", "4", "8", "C", "x"], ["x", "x", "9", "x", "x"]]
    @code = ""
    @position_x = 0
    @position_y = 2
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
    puts "#{x} #{y}"
    @keypad[x][y]
  end

  def invalid_move?(x, y)
    x < 0 || x > 4 || y < 0 || y > 4 || determine_number(x, y) == "x"
  end

  def determine_position(letter)
    case letter
      when "U"
        new_y = @position_y - 1
        @position_y -= 1 unless invalid_move?(@position_x, new_y) || @position_y == 0
      when "D"
        new_y = @position_y + 1
        @position_y += 1 unless invalid_move?(@position_x, new_y) || @position_y == 4
      when "L"
        new_x = @position_x - 1
        @position_x -= 1 unless invalid_move?(new_x, @position_y) || @position_x == 0
      when "R"
        new_x = @position_x + 1
        @position_x += 1 unless invalid_move?(new_x, @position_y) || @position_x == 4
    end
  end
end
