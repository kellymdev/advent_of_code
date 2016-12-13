class Cubicle
  WALL = "#"
  OPEN = "."

  def initialize(number, destination_x, destination_y)
    @number = number
    @floor = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
    @current_x = 1
    @current_y = 1
    @destination_x = destination_x
    @destination_y = destination_y
    @steps = 0
  end

  def run
    calculate_floor_layout

    print_floor_layout
  end

  private

  def calculate_floor_layout
    (0..99).each do |row|
      (0..99).each do |cell|
        @floor[row][cell] = determine_layout(row, cell)
      end
    end
  end

  def determine_layout(x, y)
    binary = (calculate(x, y) + @number).to_s(2)
    array = binary.split("")
    sum = array.map { |char| char.to_i }.reduce(:+)

    open_space?(sum) ? OPEN : WALL
  end

  def open_space?(sum)
    sum % 2 == 0
  end

  def calculate(x, y)
    x*x + 3*x + 2*x*y + y + y*y
  end

  def print_floor_layout
    @floor.each do |row|
      row.each do |cell|
        print cell
      end
      puts
    end
  end
end
