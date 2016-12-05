require 'digest'

class Door
  def initialize(door_id)
    @door_id = door_id
    @door_password = ""
  end

  def run
    counter = 0
    while !complete_door_password?
      id = @door_id + counter.to_s

      hash = create_md5_hash(id)

      if next_password_character?(hash)
        @door_password += password_character(hash)
      end

      counter += 1
    end

    print_door_password
  end

  private

  def complete_door_password?
    @door_password.length == 8
  end

  def next_password_character?(hash)
    hash[0..4] == "00000"
  end

  def password_character(hash)
    hash[5]
  end

  def create_md5_hash(message)
    md5 = Digest::MD5.new
    md5.update(message)
    md5.hexdigest
  end

  def print_door_password
    puts "#{@door_password}"
  end
end
