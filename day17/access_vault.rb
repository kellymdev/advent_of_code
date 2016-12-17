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
    @steps_taken = ""
    @current_row = 1
    @current_column = 1
  end

  def run
    while !in_vault_room? && !blocked?(generate_hash)
      door_list = generate_hash

      if can_move_down?(door_list)
        move_down
      elsif can_move_right?(door_list)
        move_right
      elsif can_move_up?(door_list)
        move_up
      elsif can_move_left?(door_list)
        move_left
      end

      print_steps_taken
    end

    print_line
    print_steps_taken if in_vault_room?
  end

  private

  def print_line
    puts "-" * 20
  end

  def print_steps_taken
    puts @steps_taken
  end

  def in_vault_room?
    @current_row == 7 && @current_column == 7
  end

  def move_up
    @current_row -= 2
    @steps_taken += "U"
  end

  def move_down
    @current_row += 2
    @steps_taken += "D"
  end

  def move_left
    @current_column -= 2
    @steps_taken += "L"
  end

  def move_right
    @current_column += 2
    @steps_taken += "R"
  end

  def can_move_up?(door_list)
    return false unless door?(@current_row - 1, @current_column)

    door_open?(door_list[0])
  end

  def can_move_down?(door_list)
    return false unless door?(@current_row + 1, @current_column)

    door_open?(door_list[1])
  end

  def can_move_left?(door_list)
    return false unless door?(@current_row, @current_column - 1)

    door_open?(door_list[2])
  end

  def can_move_right?(door_list)
    return false unless door?(@current_row, @current_column + 1)

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

  def generate_hash
    digest = Digest::MD5.hexdigest(@passcode + @steps_taken)

    digest[0..3].chars
  end
end
