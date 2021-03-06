class SuperKeys
  require 'digest'

  def initialize(salt)
    @salt = salt
    @hashes = []
    @indices = []
    @index = 0
    @digest = ""
  end

  def run
    100_000.times do |index|
      @hashes << create_hash(index)
    end

    while @indices.size < 64
      digest = @hashes[@index]

      char = triple_characters_contained(digest)

      if char && stream_contains_five_chars(char)
        @indices << @index
      end

      increment_index
    end

    print_indices
    print_line
    print_64th_key
  end

  private

  def create_hash(index)
    @digest = compute_digest(index)

    2016.times { rehash_digest }

    @digest
  end

  def rehash_digest
    @digest = Digest::MD5.hexdigest(@digest)
  end

  def print_indices
    puts @indices
  end

  def print_line
    puts "-" * 5
  end

  def print_64th_key
    puts @indices[63]
  end

  def stream_contains_five_chars(char)
    five = char * 5

    1000.times do |count|
      digest = @hashes[@index + count + 1]

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
