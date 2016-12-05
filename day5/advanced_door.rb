require 'digest'

class AdvancedDoor
  def initialize(door_id)
    @door_id = door_id
    @door_password = []
  end

  def run
    counter = 0
    while !complete_door_password?
      id = @door_id + counter.to_s

      hash = create_md5_hash(id)

      index = password_position(hash)

      if next_password_character?(hash) && valid_index(index)
        if @door_password[index].nil?
          @door_password[index] = password_character(hash)
        end
      end

      counter += 1
    end

    print_door_password
  end

  private

  def valid_index(index)
    (0..7).include?(index)
  end

  def complete_door_password?
    @door_password.compact.size == 8
  end

  def next_password_character?(hash)
    hash[0..4] == "00000"
  end

  def password_position(hash)
    numbers = %w(0 1 2 3 4 5 6 7)
    position = hash[5]

    if numbers.include?(position)
      position.to_i
    else
      8
    end
  end

  def password_character(hash)
    hash[6]
  end

  def create_md5_hash(message)
    md5 = Digest::MD5.new
    md5.update(message)
    md5.hexdigest
  end

  def print_door_password
    puts "#{@door_password.join("")}"
  end
end
