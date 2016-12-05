class MoveSquares
  def initialize(steps)
    @direction = "North"
    @blocks_north = 0
    @blocks_east = 0
    @steps = steps
  end

  def move_blocks
    @steps.each do |step|
      move = step[0]
      count = step[1..-1].to_i

      @direction = determine_direction(@direction, move)

      determine_blocks(@direction, count)
    end
  end

  def print_location
    puts "Blocks North: #{@blocks_north}"
    puts "Blocks East: #{@blocks_east}"
  end

  def print_blocks_from_home
    puts "Blocks from Home: #{blocks_from_home}"
  end

  private

  def blocks_from_home
    @blocks_north.abs + @blocks_east.abs
  end

  def determine_direction(old_direction, move)
    case old_direction
      when "North"
        return move == "L" ? "West" : "East"
      when "East"
        return move == "L" ? "North" : "South"
      when "South"
        return move == "L" ? "East" : "West"
      when "West"
        return move == "L" ? "South" : "North"
    end
  end

  def determine_blocks(direction, blocks)
    case direction
      when "North"
        @blocks_north += blocks
      when "East"
        @blocks_east += blocks
      when "South"
        @blocks_north -= blocks
      when "West"
        @blocks_east -= blocks
    end
  end
end
