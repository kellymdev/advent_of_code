class Robot
  def initialize(instructions)
    @instructions = format_instructions(instructions)
    @bots = {}
  end

  def run
    @instructions.each do |instruction|
      if instruction.include?("value")
        perform_value_move(instruction)
      else
        perform_move(instruction)
      end
    end

    print_bots
  end

  private

  def print_bots
    @bots.each do |bot|
      puts bot
    end
  end

  def perform_move(instruction)
    bot = instruction[4..-1].split(" gives").first.to_i
    low = instruction.split("gives low to ").last.split(" and").first
    high = instruction.split("and high to ").last

    perform_low_instruction(bot, low)
    perform_high_instruction(bot, high)
  end

  def perform_low_instruction(bot_number, low)
    if low.include?("bot")
      receiver = low[4..-1].to_i

      if @bots.has_key?(bot_number)
        add_low_to_bot(bot_number, receiver)
      else
        create_new_bot_with_low(bot_number, receiver)
      end
    elsif low.include?("output")
      if @bots.has_key?(bot_number)
        add_low_to_bot(bot_number, low)
      else
        create_new_bot_with_low(bot_number, low)
      end
    end
  end

  def add_low_to_bot(bot_number, receiver)
    @bots[bot_number][:low] = receiver
  end

  def create_new_bot_with_low(bot_number, receiver)
    new_bot = { low: receiver }

    @bots[bot_number] = new_bot
  end

  def perform_high_instruction(bot_number, high)
    if high.include?("bot")
      receiver = high[4..-1].to_i

      if @bots.has_key?(bot_number)
        add_high_to_bot(bot_number, receiver)
      else
        create_new_bot_with_high(bot_number, receiver)
      end
    elsif high.include?("output")
      if @bots.has_key?(bot_number)
        add_high_to_bot(bot_number, high)
      else
        create_new_bot_with_high(bot_number, high)
      end
    end
  end

  def add_high_to_bot(bot_number, receiver)
    @bots[bot_number][:high] = receiver
  end

  def create_new_bot_with_high(bot_number, receiver)
    new_bot = { high: receiver }

    @bots[bot_number] = new_bot
  end

  def perform_value_move(instruction)
    move = instruction[6..-1].split(" goes to bot ")
    value = move.first.to_i
    bot = move.last.to_i

    if @bots.has_key?(bot)
      if @bots[bot].has_key?(:value)
        update_value_for_bot(bot, value)
      else
        add_value_to_bot(bot, value)
      end
    else
      create_new_bot_with_value(bot, value)
    end
  end

  def update_value_for_bot(bot_number, value)
    @bots[bot_number][:value] << value
  end

  def add_value_to_bot(bot_number, value)
    @bots[bot_number][:value] = [value]
  end

  def create_new_bot_with_value(bot_number, value)
    new_bot = { value: [value] }

    @bots[bot_number] = new_bot
  end

  def format_instructions(instructions)
    instructions.split("\n")
  end
end
