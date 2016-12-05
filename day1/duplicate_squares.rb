class DuplicateSquares
  def initialize(steps)
    @direction = "North"
    @blocks_north = 0
    @blocks_east = 0
    @steps = steps
    @completed_blocks = []
    @visited = false
  end

  def move_blocks
    @steps.each do |step|
      move = step[0]
      count = step[1..-1].to_i

      @direction = determine_direction(@direction, move)

      determine_blocks(@direction, count)

      return if @visited
    end
  end

  def print_blocks_from_home
    puts "Duplicate Squares:"
    puts "Blocks from Home: #{blocks_from_home}"
  end

  private

  def already_visited?(blocks)
    @completed_blocks.include?(blocks)
  end

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
        blocks.times do
          return if @visited

          @blocks_north += 1
          current_blocks = [@blocks_north, @blocks_east]

          if already_visited?(current_blocks)
            @visited = true
            return
          end

          @completed_blocks << current_blocks
        end
      when "East"
        blocks.times do
          return if @visited

          @blocks_east += 1
          current_blocks = [@blocks_north, @blocks_east]

          if already_visited?(current_blocks)
            @visited = true
            return
          end

          @completed_blocks << current_blocks
        end
      when "South"
        blocks.times do
          return if @visited

          @blocks_north -= 1
          current_blocks = [@blocks_north, @blocks_east]

          if already_visited?(current_blocks)
            @visited = true
            return
          end

          @completed_blocks << current_blocks
        end
      when "West"
        blocks.times do
          return if @visited

          @blocks_east -= 1
          current_blocks = [@blocks_north, @blocks_east]

          if already_visited?(current_blocks)
            @visited = true
            return
          end

          @completed_blocks << current_blocks
        end
    end
  end
end
