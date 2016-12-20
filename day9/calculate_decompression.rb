class CalculateDecompression
  def initialize(input)
    @input = format_input(input)
    @decompressed_length = 0
  end

  def run
    calculate_length(@input)

    print_decompressed_length
  end

  private

  def calculate_length(data)
    array = data.chars

    while array.length > 0
      char = array.shift
      chars = 0
      count = 0

      if char == "("
        segment = array.join.split(")").first

        hash = find_chars_and_count(segment)

        group = "("
        (array.index(")") + 1).times { group += array.shift }

        hash[:chars].times { group += array.shift }

        @decompressed_length += process_string(group)
      end
    end
  end

  def process_string(string)
    puts "String: #{string}"

    middle_start = find_middle_start(string)
    middle_end = find_middle_end(string)

    middle_length = if middle_start != middle_end
                      get_middle_length(string)
                    else
                      0
                    end

    middle_start + middle_length + process_string(string[(middle_end + 1)..-1])
  end

  def find_middle_start(string)
    string.include?("(") ? string.chars.index("(") : 0
  end

  def find_middle_end(string)
    numbers = find_number_groups(string)

    if numbers.empty?
      0
    else
      pair = numbers.first
      chars = pair.first.to_i

      array = string.chars

      array.index(")") + chars
    end
  end

  def get_middle_length(string)
    start = find_middle_start(string)
    end_of_middle = find_middle_end(string)

    middle_subsection = string.chars.index(")") + 1

    count = find_first_count(string)

    middle = count * process_string(string[middle_subsection..end_of_middle])
  end

  def find_first_count(string)
    numbers = find_number_groups(string)

    !numbers.empty? ? numbers.first.last : 0
  end

  def find_number_groups(group)
    group.scan(/(\d+)[x](\d+)/)
  end

  def find_chars_and_count(segment)
    chars = segment.split("(").last.split("x").first.to_i
    count = segment.split("x").last.to_i

    { chars: chars, count: count }
  end

  def print_decompressed_length
    puts "#Length: {@decompressed_length}"
  end

  def format_input(input)
    input.chars.reject{ |char| char == " " }.join
  end
end
