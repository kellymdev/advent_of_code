class CollectCapsule
  def initialize(disc_positions)
    @positions = format_disc_positions(disc_positions)
    @discs = {}
    @time = 0
  end

  def run
    @positions.each do |position|
      create_disc(position)
    end

    offset_discs

    while !values_all_zero?
      @discs.each do |disc, value|
        move_disc(disc)
      end

      print_time
      print_discs

      increment_timer
    end
  end

  private

  def print_discs
    puts @discs
  end

  def print_time
    puts "Time: #{@time}"
  end

  def increment_timer
    @time += 1
  end

  def offset_discs
    @discs.keys.each do |key|
      offset = key.to_i - 1

      value = @discs[key][:current_position]

      @discs[key][:current_position] = (value += offset) % @discs[key][:positions]
    end
  end

  def move_disc(disc)
    disc_to_update = @discs[disc]

    value = disc_to_update[:current_position]

    disc_to_update[:current_position] = (value += 1) % disc_to_update[:positions]
  end

  def values_all_zero?
    values = []

    @discs.each do |disc, value|
      values << @discs[disc][:current_position]
    end

    values.uniq.size == 1 && values.uniq.first.zero?
  end

  def create_disc(disc_position)
    num = disc_position[6]
    positions = disc_position.split(" positions").first[12..-1].to_i
    initial_position = disc_position[-2].to_i

    disc = {
      positions: positions,
      current_position: initial_position
    }

    @discs[num] = disc
  end

  def format_disc_positions(disc_positions)
    disc_positions.split("\n")
  end

  def number_of_discs
    @positions.size
  end
end
