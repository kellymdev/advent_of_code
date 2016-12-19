class ExchangePresents
  def initialize(number_of_elves)
    @number_of_elves = number_of_elves
    @elves = create_elves
  end

  def run
    while !single_elf_has_all_the_presents?
      pass_presents
    end

    elf_with_presents = find_elf_with_all_the_presents

    print_elf_with_presents(elf_with_presents)
  end

  private

  def print_elf_with_presents(elf)
    puts elf
  end

  def find_elf_with_all_the_presents
    @elves.index(@number_of_elves) + 1
  end

  def pass_presents
    @elves.each_with_index do |presents, index|
      if presents && presents > 0

        puts "current elf index: #{index}"

        next_elf_with_presents = index_of_next_elf(index)

        puts "next elf: #{next_elf_with_presents}"

        return if next_elf_with_presents == index

        presents_to_take = @elves[next_elf_with_presents]

        @elves[index] += presents_to_take if presents_to_take
        @elves[next_elf_with_presents] = nil
      end
    end
  end

  def index_of_next_elf(current_index)
    count = 1
    next_index = (current_index + count) % @number_of_elves

    while @elves[next_index].nil?
      count += 1

      next_index = (current_index + count) % @number_of_elves
    end

    next_index
  end

  def create_elves
    elves = []

    @number_of_elves.times { elves << 1 }

    elves
  end

  def single_elf_has_all_the_presents?
    @elves.compact.size == 1
  end
end
