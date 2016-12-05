class Cipher
  LETTERS = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)

  def initialize(room_list)
    @rooms = create_rooms(room_list)
  end

  def run
    @rooms.each do |room|
      sector_id = sector_id(room)

      cipher_number = make_cipher(sector_id)

      room_name = unencode_room(cipher_number, encoded_room_name(room))

      print_room(sector_id, room_name) if contains_northpole?(room_name)
    end
  end

  private

  def contains_northpole?(room_name)
    room_name.include?("northpole")
  end

  def unencode_room(cipher_number, encoded_room_name)
    name = ""

    encoded_room_name.chars.each do |char|
      if char == "-"
        name += char
      else
        current_index = LETTERS.index(char)
        new_index = (current_index + cipher_number) % 26

        name += LETTERS[new_index]
      end
    end

    name
  end

  def make_cipher(sector_id)
    (0 + sector_id) % 26
  end

  def print_room(sector_id, room_name)
    puts "#{sector_id} #{room_name}"
  end

  def encoded_room_name(room)
    room[0..-11]
  end

  def sector_id(room)
    room[-10..-8].to_i
  end

  def create_rooms(room_list)
    room_list.split("\n")
  end
end
