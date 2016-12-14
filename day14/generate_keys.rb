class GenerateKeys
  require 'digest'

  def initialize(salt)
    @salt = salt
    @indices = []
    @index = 0
  end

  def run
    while @indices.size < 64
      digest = compute_digest(@index)
      char = triple_characters_contained(digest)

      if char && stream_contains_five_chars(char)
        @indices << @index
      end

      increment_index
    end

    print_64th_key
  end

  private

  def print_64th_key
    puts @indices[63]
  end

  def stream_contains_five_chars(char)
    five = char * 5

    1000.times do |count|
      digest = compute_digest(@index + count + 1)

      return true if digest.include?(five)
    end

    false
  end

  def triple_characters_contained(digest)
    digest.chars.each_with_index do |char, index|
      if digest[index + 1] == char && digest[index + 2] == char
        return char
      end
    end

    nil
  end

  def increment_index
    @index += 1
  end

  def compute_digest(index)
    Digest::MD5.hexdigest(@salt + index.to_s)
  end
end
