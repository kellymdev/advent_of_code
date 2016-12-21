class IpAddress
  def initialize(blacklist, minimum_value, maximum_value)
    @blacklist = format_blacklist(blacklist)
    @minimum_value = minimum_value
    @maximum_value = maximum_value
    @blacklisted_values = []
  end

  def run
    return unless starts_with_zero?(@blacklist.first)

    @blacklist.each do |range|
      start_value = start_value(range)
      end_value = end_value(range)

      @blacklisted_values += (start_value..end_value).to_a

      @blacklisted_values.uniq
    end


  end

  private

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
