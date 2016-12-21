class CalculateDecompression
  def initialize(input)
    @input = format_input(input)
    @decompressed_length = 0
  end

  def run
    @decompressed_length = calculate_length(@input)

    print_decompressed_length
  end

  private

  def calculate_length(data)
    middle_offset = data.index('(')
    return data.length unless middle_offset

    numbers = find_number_groups(data)

    middle_multiplier = numbers[2].to_i
    middle_length = numbers[1].to_i

    middle_start = middle_offset + numbers.to_s.length
    middle_string = find_middle_string(data, middle_start, middle_length)

    tail = find_last_part(data, middle_start, middle_length)

    middle_offset +
      middle_multiplier * calculate_length(middle_string) +
      calculate_length(tail)
  end

  def find_middle_string(string, middle_start, middle_length)
    string[middle_start, middle_length]
  end

  def find_last_part(string, middle_start, middle_length)
    string[(middle_start + middle_length)..-1]
  end

  def find_number_groups(string)
    /\((\d+)x(\d+)\)/.match string
  end

  def print_decompressed_length
    puts "Length: #{@decompressed_length}"
  end

  def format_input(input)
    input.chars.reject{ |char| char == " " }.join
  end
end
