class MoveData
  def initialize(data_structure)
    @data_structure = format_data(data_structure)
    @grid = format_grid
  end

  def run
    print_grid
  end

  private

  def print_grid
    @grid.each do |row|
      row.each do |cell|
        print "#{cell},"
      end

      puts
    end
  end

  def format_grid
    x = find_highest_x_value
    y = find_highest_y_value

   grid = create_grid(x, y)
   populate_grid(grid, x)
  end

  def populate_grid(grid, x)
    @data_structure.each do |node|
      coords = node_x_y(node[:name])

      grid[coords[:y]][coords[:x]] = "#{node[:used]}/#{node[:available]}"
    end

    grid
  end

  def create_grid(x, y)
    grid = []

    (y + 1).times { grid << [] }

    grid.each do |row|
      (x + 1).times { row << "." }
    end
  end

  def find_highest_x_value
    highest_node = @data_structure.max_by do |node|
      node_x_y(node[:name])[:x]
    end

    node_x_y(highest_node[:name])[:x]
  end

  def find_highest_y_value
    highest_node = @data_structure.max_by do |node|
      node_x_y(node[:name])[:y]
    end

    node_x_y(highest_node[:name])[:y]
  end

  def format_data(data_structure)
    data = data_structure.split("\n")
    2.times { data.shift } # this removes the header rows

    array = []

    data.each do |node|
      node_data = node_size(node)

      file = {
        name: node_name(node),
        size: node_data[:size],
        used: node_data[:used],
        available: node_data[:available]
      }

      array << file
    end

    array
  end

  def node_x_y(node_name)
    data = node_name.scan(/x(\d+)-y(\d+)/)

    {
      x: data.first.first.to_i,
      y: data.first.last.to_i
    }
  end

  def node_name(node)
    /(\/dev\/grid\/node-x\d+-y\d+)/.match(node)[1]
  end

  def node_size(node)
    data = node.scan(/(\d+)T/)

    {
      size: data.first.first.to_i,
      used: data[1].first.to_i,
      available: data[2].first.to_i
    }
  end
end
