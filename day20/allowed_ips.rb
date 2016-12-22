class AllowedIps
  def initialize(blacklist, minimum_value, maximum_value)
    @blacklist = format_blacklist(blacklist)
    @minimum_value = minimum_value
    @maximum_value = maximum_value
    @current_minimum = nil
    @current_maximum = nil
    @blacklisted_values = []
    @valid_ip_ranges = []
  end

  def run
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
        # the value is a valid ip
        @valid_ip_ranges << [consecutive_value_for_maximum, lowest - 1]

        update_current_maximum(highest)
      end
    end

    if @current_maximum != @maximum_value
      @valid_ip_ranges << [consecutive_value_for_maximum, @maximum_value]
    end

    ip_count = calculate_valid_ips

    print_ip_count(ip_count)
  end

  private

  def print_ip_count(ip_count)
    puts "Ip count: #{ip_count}"
  end

  def calculate_valid_ips
    @valid_ip_ranges.map { |values| values.last - values.first + 1 }.reduce(:+)
  end

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
