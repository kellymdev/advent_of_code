class Tile
  SAFE_TILE = "."
  TRAP = "^"

  def initialize(start_row, number_of_rows)
    @number_of_rows = number_of_rows
    @number_of_columns = start_row.size
    @map = create_map(start_row)
  end

  def run
    (@number_of_rows - 1).times do |index|
      puts "creating tiles for row #{index + 1}"
      create_tiles_for(index + 1)
    end

    tiles = count_number_of_safe_tiles

    print_map

    print_tile_count(tiles)
  end

  private

  def create_tiles_for(row_number)
    @number_of_columns.times do |column|
      create_tile(column, row_number)
    end
  end

  def create_tile(column, row_number)
    previous_row = row_number - 1

    left_tile = if left_edge_tile?(column)
                  SAFE_TILE
                else
                  @map[previous_row][column - 1]
                end

    centre_tile = @map[previous_row][column]

    right_tile = if right_edge_tile?(column)
                   SAFE_TILE
                 else
                   @map[previous_row][column + 1]
                 end

    @map[row_number] << determine_new_tile(left_tile, centre_tile, right_tile)
  end

  def determine_new_tile(left_tile, centre_tile, right_tile)
    tiles = left_tile + centre_tile + right_tile

    if tiles == "#{TRAP}#{TRAP}#{SAFE_TILE}" ||
      tiles == "#{SAFE_TILE}#{TRAP}#{TRAP}" ||
      tiles == "#{TRAP}#{SAFE_TILE}#{SAFE_TILE}" ||
      tiles == "#{SAFE_TILE}#{SAFE_TILE}#{TRAP}"
      TRAP
    else
      SAFE_TILE
    end
  end

  def left_edge_tile?(column)
    column.zero?
  end

  def right_edge_tile?(column)
    column == @number_of_columns - 1
  end

  def safe_tile?(tile)
    tile == SAFE_TILE
  end

  def trap?(tile)
    tile == TRAP
  end

  def print_tile_count(tiles)
    puts tiles
  end

  def count_number_of_safe_tiles
    @map.flatten.select { |tile| tile == "." }.count
  end

  def print_map
    @map.each do |row|
      row.each do |cell|
        print cell
      end

      puts
    end
  end

  def create_map(start_row)
    map = []

    @number_of_rows.times do
      map << []
    end

    map[0] = start_row.chars

    map
  end
end
