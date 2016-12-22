class DataGrid
  def initialize(data_structure)
    @data_structure = format_data(data_structure)
    @node_pairs = []
  end

  def run
    @data_structure.each do |node|
      used = node[:used]

      next if used.zero?

      nodes_that_will_fit_data(node[:name], used)
    end

    @node_pairs.uniq

    print_number_of_nodes
  end

  private

  def print_number_of_nodes
    puts @node_pairs.size
  end

  def nodes_that_will_fit_data(node_name, node_used)
    @data_structure.each do |node|
      name = node[:name]

      next if node_name == name

      size = node[:available]

      if size > node_used
        @node_pairs << [node_name, name].sort
      end
    end
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
