class LongestRoute
  require 'digest'

  LAYOUT = [["#", "#", "#", "#", "#", "#", "#", "#", "#"],
            ["#", "S", "|", ".", "|", ".", "|", ".", "#"],
            ["#", "-", "#", "-", "#", "-", "#", "-", "#"],
            ["#", ".", "|", ".", "|", ".", "|", ".", "#"],
            ["#", "-", "#", "-", "#", "-", "#", "-", "#"],
            ["#", ".", "|", ".", "|", ".", "|", ".", "#"],
            ["#", "-", "#", "-", "#", "-", "#", "-", "#"],
            ["#", ".", "|", ".", "|", ".", "|", ".", "#"],
            ["#", "#", "#", "#", "#", "#", "#", "#", "V"]]

  DOOR = %w(| -)
  START_ROOM = "S"
  ROOMS = [START_ROOM, "."]

  DOOR_OPEN = %w(b c d e f)

  def initialize(passcode)
    @passcode = passcode
    @positions = [""]
    @start_row = 1
    @start_column = 1
  end

  def run
    steps = 0
    door_list = generate_hash("")

    moves = calculate_possible_moves(door_list, [@start_row, @start_column])

    @positions = moves.chars

    while @positions.length > 0
      step = @positions.shift
      position = calculate_current_position(step)

      if in_vault_room?(position)
        steps = [step.length, steps].max
      else
        door_codes = generate_hash(step)

        next_moves = calculate_possible_moves(door_codes, position)

        if next_moves
          next_moves.chars.each do |char|
            @positions << step + char
          end
        end
      end
    end

    print_steps(steps)
  end

  private

  def print_steps(steps)
    puts steps
  end

  def calculate_maximum_steps
    @positions.first.size
  end

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

  def calculate_possible_moves(door_list, position)
    row = position[0]
    column = position[1]

    moves = ""
    moves += "U" if can_move_up?(door_list, row, column)
    moves += "D" if can_move_down?(door_list, row, column)
    moves += "L" if can_move_left?(door_list, row, column)
    moves += "R" if can_move_right?(door_list, row, column)

    moves
  end

  def print_steps_taken
    puts @steps_taken
  end

  def in_vault_room?(position)
    position[0] == 7 && position[1] == 7
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
