class GenerateDragon
  def initialize(initial_state, disk_length)
    @data = initial_state
    @disk_length = disk_length
    @checksum = ""
  end

  def run
    while @data.size < @disk_length
      create_data
    end

    fit_data_to_disk

    calculate_checksum(@data)

    while checksum_even?
      calculate_checksum(@checksum)
    end

    print_data
    print_line
    print_checksum
  end

  private

  def checksum_even?
    @checksum.size % 2 == 0
  end

  def calculate_checksum(data)
    @checksum = ""
    pairs = data.scan(/../)

    pairs.each do |pair|
      if pair[0] == pair[1]
        @checksum += "1"
      else
        @checksum += "0"
      end
    end
  end

  def fit_data_to_disk
    @data = @data.chars.take(@disk_length).join
  end

  def print_checksum
    puts @checksum
  end

  def print_line
    puts "-" * 20
  end

  def print_data
    puts @data
  end

  def create_data
    switched = switch_data(@data.reverse)

    @data += "0"
    @data += switched
  end

  def switch_data(data)
    data.gsub(/[01]/, "0" => "1", "1" => "0")
  end
end
