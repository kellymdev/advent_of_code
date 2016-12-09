class CalculateDecompression
  LETTERS = /[A-Z]+/

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

        (array.index(")") + 1).times { array.shift }

        group = ""
        hash[:chars].times { group += array.shift }
        hash[:count].times { @decompressed_length += calculate_filtered_length(group) }

        group.chars.reverse.each { |char| array.unshift(char) }
      else
        @decompressed_length += 1
      end
    end
  end

  def calculate_filtered_length(group)
    LETTERS.match(group).to_s.size
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
