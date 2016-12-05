class ColumnTriangle
  def initialize(triangle_list)
    @triangles = []
    @triangle_list = format_triangles(triangle_list)
    @count = 0
  end

  def count_triangles
    @triangles.each do |triangle|
      @count += 1 if valid_triangle?(triangle)
    end
  end

  def print_count
    puts "Valid triangles: #{@count}"
  end

  private

  def format_triangles(triangle_list)
    rows = create_rows(triangle_list)

    while rows.length > 0
      working_array = []

      3.times { working_array << rows.shift }

      3.times do |index|
        x = working_array[0].split(" ")[index]
        y = working_array[1].split(" ")[index]
        z = working_array[2].split(" ")[index]

        puts "#{x} #{y} #{z}"

        @triangles << [x, y, z]
      end
    end
  end

  def create_rows(triangle_list)
    triangle_list.split("\n")
  end

  def valid_triangle?(triangle)
    x = triangle[0].to_i
    y = triangle[1].to_i
    z = triangle[2].to_i

    two_sides_larger?(x, y, z) && two_sides_larger?(y, z, x) && two_sides_larger?(z, x, y)
  end

  def two_sides_larger?(x, y, z)
    (x + y) > z
  end
end
