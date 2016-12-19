class ExchangePresentsInCircle
  def initialize(number_of_elves)
    @number_of_elves = number_of_elves
    @elves = create_elves
  end

  def run
    index = 0

    while !one_elf_has_all_the_presents?
      puts "Index: #{index}"

      elf = @elves[index]
      puts "Elf: #{elf}"

      elf_to_take_from = elf_across_the_circle(index)
      puts "Index of elf to take from: #{elf_to_take_from}"

      presents_to_take = @elves[elf_to_take_from].values.join.to_i

      elf_number = elf.keys.join.to_i
      puts "Elf number: #{elf_number}"

      elf[elf_number] += presents_to_take

      @elves[elf_to_take_from] = nil

      index = (index + 1) % @elves.size

      @elves.compact!
    end

    print_elves
  end

  private

  def elf_across_the_circle(current_index)
    half = @elves.size / 2

    if even?(half)
      (half + current_index) % @elves.size
    else
      (half.floor + current_index) % @elves.size
    end
  end

  def even?(number)
    (number % 2).zero?
  end

  def elves_left_in_circle
    @elves.size
  end

  def print_elves
    puts @elves
  end

  def create_elves
    elves = []

    @number_of_elves.times do |elf|
      elves << { elf + 1 => 1 }
    end

    elves
  end

  def one_elf_has_all_the_presents?
    @elves.size == 1
  end
end
