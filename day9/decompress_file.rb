class DecompressFile
  def initialize(input)
    @input = input
    @decompressed = ""
    @decompressed_length = 0
  end

  def run
    uncompress_data(@input)

    calculate_decompressed_length

    print_decompressed
    print_decompressed_length
  end

  private

  def uncompress_data(data)
    array = data.chars

    while array.length > 0
      char = array.shift

      if char == "("
        segment = data.split(")").first

        hash = find_chars_and_count(segment)

        (array.index(")") + 1).times { array.shift }

        group = ""
        hash[:chars].times { group += array.shift }
        hash[:count].times { @decompressed += group }
      else
        @decompressed += char
      end
    end
  end

  def find_chars_and_count(segment)
    chars = segment.split("(").last.split("x").first.to_i
    count = segment.split("x").last.to_i

    { chars: chars, count: count }
  end

  def calculate_decompressed_length
    @decompressed_length = @decompressed.size
  end

  def print_decompressed_length
    puts "#{@decompressed_length}"
  end

  def print_decompressed
    puts "#{@decompressed}"
  end
end
