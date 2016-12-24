class AccessLocations
  WALL = "#"
  OPEN_SPACES = %w(. 0 1 2 3 4 5 6 7 8 9)

  def initialize(map)
    @non_zero_number_count = non_zero_count(map)
    @map = format_map(map)
  end

  def run
    start = find_start_location
  end

  private

  def find_start_location
    @map.each_with_index do |row, index|
      if row.include?("0")
        x = row.index("0")

        return {
          x: x,
          y: index
        }
      end
    end
  end

  def open_space?(char)
    OPEN_SPACES.include?(char)
  end

  def wall?(char)
    char == WALL
  end

  def non_zero_count(map)
    map.chars.reject { |char| char.to_i.zero? }.count
  end

  def format_map(map)
    map.split("\n")
  end
end
