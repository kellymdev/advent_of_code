class GenerateDragon
  def initialize(initial_state, disk_length)
    @data = initial_state
    @disk_length = disk_length
    @checksum = ""
  end

  def run
    while @data.size < @disk_length
      puts "Data size: #{@data.size}"
      create_data
    end

    puts "Data size: #{@data.size}"

    fit_data_to_disk

    puts "Data trimmed to: #{@data.size}"

    @checksum = @data

    while checksum_even?
      puts "Calculating checksum... #{@checksum.length}"
      calculate_checksum
    end

    print_checksum
  end

  private

  def checksum_even?
    @checksum.size % 2 == 0
  end

  def calculate_checksum
    @checksum.gsub!(/../,'00'=>'1', '11'=> '1', '10'=> '0', '01'=>"0")
  end

  def fit_data_to_disk
    @data = @data[0...@disk_length]
  end

  def print_checksum
    puts @checksum
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
