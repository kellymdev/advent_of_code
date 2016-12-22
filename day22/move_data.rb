class MoveData
  def initialize(data_structure)
    @data_structure = format_data(data_structure)
  end

  def run
  end

  private

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
