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
    @steps = 0
  end

  def run
    @input.each_with_index do |floor, index|
      add_floor_data_to_building(floor, index)
    end

    print_building_layout
  end

  private

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
    elsif equipment2.include?(MICROCHIP)
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

  def add_floor_data_to_building(floor, index)
    return if floor.include?("contains nothing relevant")

    data = floor.split("contains a ").last
    isotopes = data.split(", a ")

    isotopes.each do |isotope|
      equipment = find_symbol_for_equipment(isotope)
      add_equipment_to_floor(equipment, index)
    end
  end

  def find_symbol_for_equipment(equipment)
    if equipment.include?("microchip")
      MICROCHIPS.key(equipment)
    elsif equipment.include?("generator")
      GENERATORS.key(equipment)
    end
  end

  def add_equipment_to_floor(equipment_symbol, floor)
    @building[floor] << equipment_symbol
  end

  def format_input(input)
    input.split(".\n")
  end
end
