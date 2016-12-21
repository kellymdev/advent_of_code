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
    @possible_moves = []
  end

  def run
    @input.each_with_index do |floor, index|
      add_floor_data_to_building(floor, index)
    end

    # while !all_equipment_on_top_floor?
      find_possible_moves
    # end

    puts "Possible moves: #{@possible_moves}"

    print_building_layout
  end

  private

  def find_possible_moves
    @building.each_with_index do |floor, index|
      if index < 3
        floor.each do |equipment|
          if compatible_equipment_on_floor?(equipment, index + 1)
            move = {
              equipment: [equipment],
              from_index: index,
              to_index: index + 1
            }

            @possible_moves << move
          end

          if microchip?(equipment) && microchip_and_compatible_generator_on_floor?(equipment, index)
            generator = equipment[0] + "g"

            if compatible_equipment_on_floor?(equipment, index + 1) && compatible_equipment_on_floor?(equipment, index + 1)

              move = {
                equipment: [equipment, generator.to_sym],
                from_index: index,
                to_index: index + 1
              }

              @possible_moves << move
            end
          end
        end
      end
    end
  end

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

  def microchip_and_compatible_generator_on_floor?(equipment, floor_index)
    if microchip?(equipment)
      generator = equipment[0] + "g"

      @building[floor_index].include?(generator.to_sym)
    elsif generator?(equipment)
      microchip = equipment[0] + "m"

      @building[floor_index].include?(microchip.to_sym)
    end
  end

  def compatible_equipment_on_floor?(equipment1, floor_index)
    compatibility = @building[floor_index].map do |equipment2|
      compatible_equipment?(equipment1, equipment2)
    end

    !compatibility.include?(false)
  end

  def compatible_equipment?(equipment1, equipment2)
    if both_generators?(equipment1, equipment2) ||
      both_microchips?(equipment1, equipment2)
      return true
    elsif microchip_and_generator?(equipment1, equipment2)
      compatible_microchip_and_generator?(equipment1, equipment2)
    end
  end

  def compatible_microchip_and_generator?(microchip, generator)
    microchip[0] == generator[0]
  end

  def both_generators?(equipment1, equipment2)
    generator?(equipment1) && generator?(equipment2)
  end

  def both_microchips?(equipment1, equipment2)
    microchip?(equipment1) && microchip?(equipment2)
  end

  def microchip_and_generator?(equipment1, equipment2)
    generator?(equipment1) && microchip(equipment2) ||
    microchip?(equipment1) && generator?(equipment2)
  end

  def generator?(equipment)
    equipment.to_s.include?(GENERATOR)
  end

  def microchip?(equipment)
    equipment.to_s.include?(MICROCHIP)
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
    @equipment_count += 1
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
