class IpAddress
  def initialize(blacklist, minimum_value, maximum_value)
    @blacklist = format_blacklist(blacklist)
    @minimum_value = minimum_value
    @maximum_value = maximum_value
    @current_minimum = nil
    @current_maximum = nil
    @blacklisted_values = []
    @lowest_ip = 0
  end

  def run
    return unless starts_with_zero?(@blacklist.first)

    create_blacklisted_values

    @blacklisted_values.each do |value|
      lowest = value[0]
      highest = value[1]

      update_current_minimum(lowest) if @current_minimum.nil?
      update_current_maximum(highest) if @current_maximum.nil?

      if value_included_in_range?(lowest) || consecutive_value_for_maximum == lowest
        if !value_included_in_range?(highest)
          update_current_maximum(highest)
        end
      else
        @lowest_ip = consecutive_value_for_maximum

        break
      end
    end

    print_lowest_ip
  end

  private

  def create_blacklisted_values
    @blacklist.each_with_index do |range, index|
      puts "Processing record #{index}"

      start_value = start_value(range)
      end_value = end_value(range)

      @blacklisted_values << [start_value, end_value]
      @blacklisted_values.sort!
    end
  end

  def update_current_minimum(value)
    @current_minimum = value
  end

  def update_current_maximum(value)
    @current_maximum = value
  end

  def consecutive_value_for_maximum
    @current_maximum + 1
  end

  def consecutive_value_for_minimum
    @current_minimum - 1
  end

  def value_included_in_range?(value)
    (@current_minimum..@current_maximum).include?(value)
  end

  def print_lowest_ip
    puts "Lowest ip: #{@lowest_ip}"
  end

  def starts_with_zero?(range)
    start_value(range).zero?
  end

  def start_value(range)
    range.scan(/(\d+)[-]/).first.first.to_i
  end

  def end_value(range)
    range.scan(/[-](\d+)/).first.first.to_i
  end

  def format_blacklist(blacklist)
    blacklist.split("\n").sort
  end
end
