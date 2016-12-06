class LessCommonMessage
  def initialize(message_list)
    @messages = create_messages(message_list)
    @message = ""
  end

  def run
    message_length.times do |t|
      letters = ""

      @messages.each do |message|
        letters += message[t]
      end

      @message += least_common_letter(letters)
    end

    print_message
  end

  private

  def print_message
    puts "#{@message}"
  end

  def least_common_letter(letters)
    frequencies = calculate_frequencies(letters)

    sorted = frequencies.sort_by { |letter, frequency| [frequency, letter] }

    letter = sorted.take(1)
    letter[0][0]
  end

  def calculate_frequencies(letters)
    frequencies = {}

    letters.chars.each do |letter|
      if frequencies.has_key?(letter)
        frequencies[letter] += 1
      else
        frequencies[letter] = 1
      end
    end

    frequencies
  end

  def message_length
    @messages.first.size
  end

  def create_messages(message_list)
    message_list.split("\n")
  end
end
