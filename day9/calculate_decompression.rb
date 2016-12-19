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

        (array.index(")") + 1).times { array.shift }

        group = ""
        hash[:chars].times { group += array.shift }

        numbers = group.scan(/(\d+)[x](\d+)/)

        if numbers.empty?
          segment_characters = group.scan(/[A-Z]/).size
          total = hash[:count] * segment_characters
          @decompressed_length += total
        else
          numbers.each do |number_pair|
            char_match = number_pair[0]
            count_match = number_pair[1].to_i
            new_count = count_match * hash[:count]

            group.gsub!(/#{char_match}[x]#{count_match}/, "#{char_match}x#{new_count}")
          end

          group.chars.reverse.each { |char| array.unshift(char) }
        end
      else
        @decompressed_length += 1
      end
    end
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
