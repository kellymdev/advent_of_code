class Room
  def initialize(room_list)
    @rooms = create_rooms(room_list)
    @sector_ids = []
  end

  def run
    @rooms.each do |room|
      save_sector_id(room) if valid_room?(room)
    end

    sum = sum_sector_ids
    print_sector_sum(sum)
  end

  private

  def print_sector_sum(sum)
    puts sum
  end

  def valid_room?(room)
    name = room_name(room)

    frequencies = find_letter_frequencies(name)

    letters = top_letters(frequencies)

    letters == checksum(room)
  end

  def top_letters(frequencies)
    letters = frequencies.sort_by { |letter, frequency| [-Integer(frequency), letter] }

    most_common_letters = letters.take(5)

    top = ""

    most_common_letters.each do |letter|
      top += letter[0]
    end

    top
  end

  def next_letter_same_freq?(letters, current_index)
    letters[current_index][1] == letters[current_index + 1][1]
  end

  def sort_letters(letters)
    letters.chars.sort.join("")
  end

  def find_letter_frequencies(room_name)
    frequencies = {}

    room_name.chars.each do |char|
      unless ignore_char?(char)
        if frequencies.has_key?(char)
          frequencies[char] += 1
        else
          frequencies[char] = 1
        end
      end
    end

    frequencies
  end

  def ignore_char?(char)
    char == "-"
  end

  def save_sector_id(room)
    @sector_ids << sector_id(room)
  end

  def create_rooms(room_list)
    room_list.split("\n")
  end

  def room_name(room)
    room[0..-11].chars.sort.join("")
  end

  def sector_id(room)
    room[-10..-8].to_i
  end

  def checksum(room)
    room[-6..-2]
  end

  def sum_sector_ids
    @sector_ids.reduce(&:+)
  end
end
