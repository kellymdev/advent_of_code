class Radioisotope
  MICROCHIP = "m"
  GENERATOR = "g"

  MICROCHIPS = {
    hm: "hydrogen-compatible microchip",
    lm: "lithium-compatible microchip",
    om: "promethium-compatible microchip",
    pm: "plutonium-compatible microchip",
    rm: "ruthenium-compatible microchip",
    sm: "strontium-compatible microchip",
    tm: "thulium-compatible microchip"
  }

  GENERATORS = {
    hg: "hydrogen generator",
    lg: "lithium generator",
    og: "promethium generator",
    pg: "plutonium generator",
    rg: "ruthenium generator",
    sg: "strontium generator",
    tg: "thulium generator"
  }

  def initialize(input)
    @input = format_input(input)
    @building = [[],[],[],[]]
    @elevator = []
    @equipment_count = 0
    @steps = 0
  end

  def run
    @input.each_with_index do |floor, index|
      add_floor_data_to_building(floor, index)
    end

    print_building_layout
  end

  private

  def move_between_floors(start_floor, end_floor, equipment)
    raise "Can only move 1 floor at a time" unless (end_floor - start_floor).abs == 1

    @building[start_floor - 1] -= [equipment]
    @building[end_floor - 1] += [equipment]

    increment_steps
  end

  def increment_steps
    @steps += 1
  end

  def can_use_elevator?
    !@elevator.empty? && @elevator.size < 3
  end

  def elevator_empty?
    @elevator.empty?
  end

  def print_building_layout
    @building.each_with_index do |floor, index|
      puts "F#{index + 1} #{floor}"
    end
  end

  def compatible_equipment?(equipment1, equipment2)
    if both_generators?(equipment1, equipment2) ||
      both_microchips?(equipment1, equipment2)
      return true
    elsif microchip_and_generator?(equipment1, equipment2)
      compatible_microchip_and_generator?(equipment1, equipment2)
    end
  end

  def compatible_microchip_and_generator(microchip, generator)
    microchip[0] == generator[0]
  end

  def both_generators?(equipment1, equipment2)
    equipment1.include?(GENERATOR) && equipment2.include?(GENERATOR)
  end

  def both_microchips?(equipment1, equipment2)
    equipment1.include?(MICROCHIP) && equipment2.include?(MICROCHIP)
  end

  def microchip_and_generator?(equipment1, equipment2)
    equipment1.include?(GENERATOR) && equipment2.include?(MICROCHIP) ||
    equipment1.include?(MICROCHIP) && equipment2.include?(GENERATOR)
  end

  def add_floor_data_to_building(floor, index)
    return if floor.include?("contains nothing relevant")

    data = floor.split("contains a ").last
    isotopes = data.split(", a ")

    isotopes.each do |isotope|
      equipment = find_symbol_for_equipment(isotope)
      add_equipment_to_floor(equipment, index)
      increment_equipment_count
    end
  end

  def increment_equipment_count
    @equipment += 1
  end

  def find_symbol_for_equipment(equipment)
    if equipment.include?("microchip")
      MICROCHIPS.key(equipment)
    elsif equipment.include?("generator")
      GENERATORS.key(equipment)
    end
  end

  def all_equipment_on_top_floor?
    @building[3].size == @equipment_count
  end

  def add_equipment_to_floor(equipment_symbol, floor)
    @building[floor] << equipment_symbol
  end

  def format_input(input)
    input.split(".\n")
  end
end
