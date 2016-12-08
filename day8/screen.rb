class Screen
  DISPLAY_WIDTH = 50
  DISPLAY_HEIGHT = 6
  ON = "#"
  OFF = "."

  def initialize(instructions)
    @instructions = format_instructions(instructions)
    @display = create_display
  end

  def run
    @instructions.each do |instruction|
      if instruction.include?("rect")
        perform_rect(instruction)
      elsif instruction.include?("column")
        perform_rotate_column(instruction)
      elsif instruction.include?("row")
        perform_rotate_row(instruction)
      end
    end

    pixels = count_on_pixels
    print_pixel_count(pixels)

    print_display
  end

  private

  def perform_rotate_row(instruction)
    values = instruction[13..-1].split(" by ")
    row = values.first.to_i
    move = values.last.to_i

    rotate_row(row, move)
  end

  def rotate_row(row_number, move)
    row_to_move = @display[row_number].map { |x| x }

    DISPLAY_WIDTH.times do |index|
      @display[row_number][(move + index) % DISPLAY_WIDTH] = row_to_move[index]
    end
  end

  def perform_rotate_column(instruction)
    values = instruction[16..-1].split(" by ")
    column = values.first.to_i
    move = values.last.to_i

    rotate_column(column, move)
  end

  def rotate_column(column_number, move)
    column_to_move = @display.transpose[column_number].map { |x| x }

    DISPLAY_HEIGHT.times do |index|
      @display[(move + index) % DISPLAY_HEIGHT][column_number] = column_to_move[index]
    end
  end

  def perform_rect(instruction)
    values = instruction[5..-1].split("x")
    width = values.first.to_i
    height = values.last.to_i

    create_rectangle(width, height)
  end

  def create_rectangle(width, height)
    height.times do |row|
      width.times do |cell|
        @display[row][cell] = ON
      end
    end
  end

  def count_on_pixels
    count = 0

    @display.each do |row|
      row.each do |cell|
        count += 1 if cell == ON
      end
    end

    count
  end

  def print_display
    @display.each do |row|
      row.each do |cell|
        print cell
      end
      puts
    end
  end

  def print_pixel_count(pixels)
    puts "#{pixels}"
  end

  def create_display
    [[OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF],
    [OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF],
    [OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF],
    [OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF],
    [OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF],
    [OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
      OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF]]
  end

  def format_instructions(instructions)
    instructions.split("\n")
  end
end
