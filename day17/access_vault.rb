class AccessVault
  require 'digest'

  LAYOUT = [["#", "#", "#", "#", "#", "#", "#", "#", "#"],
            ["#", "S", "|", ".", "|", ".", "|", ".", "#"],
            ["#", "-", "#", "-", "#", "-", "#", "-", "#"],
            ["#", ".", "|", ".", "|", ".", "|", ".", "#"],
            ["#", "-", "#", "-", "#", "-", "#", "-", "#"],
            ["#", ".", "|", ".", "|", ".", "|", ".", "#"],
            ["#", "-", "#", "-", "#", "-", "#", "-", "#"],
            ["#", ".", "|", ".", "|", ".", "|", ".", "."],
            ["#", "#", "#", "#", "#", "#", "#", ".", "V"]]

  DOOR = %w(| -)
  START_ROOM = "S"
  ROOMS = [START_ROOM, "."]

  DOOR_OPEN = %w(b c d e f)

  def initialize(passcode)
    @passcode = passcode
    @possible_steps = []
    @steps_taken = ""
    @start_row = 1
    @start_column = 1
  end

  def run
    door_list = generate_hash("")

    moves = calculate_possible_moves(door_list, @start_row, @start_column)

    @possible_steps = moves.chars

    loop do
      @possible_steps.compact.uniq.each_with_index do |step, index|
        puts step

        position = calculate_current_position(step)
        puts position

        if in_vault_room?(position[0], position[1])
          @steps_taken = step.join
          print_steps_taken

          return
        end

        door_list = generate_hash(step)

        moves = calculate_possible_moves(door_list, position[0], position[1])

        @possible_steps[index] = nil


        if moves
          moves.chars.each do |char|
            @possible_steps << step + char
          end
        end
      end
    end
  end

  private

  def calculate_current_position(steps)
    row = @start_row
    column = @start_column

    steps.chars.each do |step|
      case step
        when "U" then row -= 2
        when "D" then row += 2
        when "L" then column -= 2
        when "R" then column += 2
      end
    end

    [row, column]
  end

  def calculate_possible_moves(door_list, row, column)
    moves = ""
    moves += "U" if can_move_up?(door_list, row, column)
    moves += "D" if can_move_down?(door_list, row, column)
    moves += "L" if can_move_left?(door_list, row, column)
    moves += "R" if can_move_right?(door_list, row, column)
  end

  def print_steps_taken
    puts @steps_taken
  end

  def in_vault_room?(row, column)
    row == 7 && column == 7
  end

  def can_move_up?(door_list, row, column)
    return false unless door?(row - 1, column)

    door_open?(door_list[0])
  end

  def can_move_down?(door_list, row, column)
    return false unless door?(row + 1, column)

    door_open?(door_list[1])
  end

  def can_move_left?(door_list, row, column)
    return false unless door?(row, column - 1)

    door_open?(door_list[2])
  end

  def can_move_right?(door_list, row, column)
    return false unless door?(row, column + 1)

    door_open?(door_list[3])
  end

  def blocked?(door_list)
    !can_move_up?(door_list) && !can_move_down?(door_list) && !can_move_left?(door_list) && !can_move_right?(door_list)
  end

  def door?(row, column)
    DOOR.include?(LAYOUT[row][column])
  end

  def door_open?(door_code)
    DOOR_OPEN.include?(door_code)
  end

  def generate_hash(steps)
    digest = Digest::MD5.hexdigest(@passcode + steps)

    digest[0..3].chars
  end
end
