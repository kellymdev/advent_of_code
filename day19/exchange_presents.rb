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

        presents_to_take = @elves[next_elf_with_presents]

        @elves[index] += presents_to_take if presents_to_take
        @elves[next_elf_with_presents] = nil
      end
    end
  end

  def index_of_next_elf(current_index)
    next_index = (current_index + 1) % @number_of_elves

    if @elves[next_index].nil?
      next_elf_value = @elves[next_index..-1].select { |elf| elf > 0 if elf }.first
      index = @elves[next_index..-1].index(next_elf_value) + next_index

      unless index
        next_elf_value = @elves[0..(current_index - 1)].select { |elf| elf > 0 if elf }.first
        index = @elves[0..(current_index - 1)].index(next_elf_value)
      end

      index
    else
      next_index
    end
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
