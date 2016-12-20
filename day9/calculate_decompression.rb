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

        group = ""
        (array.index(")") + 1).times { group += array.shift }

        hash[:chars].times { group += array.shift }

        @decompressed_length += process_string(group)
      end
    end
  end

  def process_string(string)
    puts "String: #{string}"

    first_part = find_first_part(string)
    middle_part = find_middle_part(string)
    last_part = find_last_part(string)

    puts "1: #{first_part}"
    puts "2: #{middle_part}"
    puts "3: #{last_part}"

    first_part.size + find_first_number(string) * process_string(middle_part) + process_string(last_part)
  end

  def find_first_part(string)
    string.scan(/([A-Z]*)\(/).first.first
  end

  def find_middle_part(string)
    string.scan(/\(\d+[x]\d+\)/).first
  end

  def find_last_part(string)
    middle_part = find_middle_part(string)

    string.split(middle_part).last
  end

  def find_first_number(string)
    string.scan(/(\d+)[x]/).first.first.to_i
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
    puts "#{@decompressed_length}"
  end

  def format_input(input)
    input.chars.reject{ |char| char == " " }.join
  end
end
