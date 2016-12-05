class Triangle
  def initialize(triangles)
    @triangles = format_triangles(triangles)
    @count = 0
  end

  def count_triangles
    @triangles.each do |triangle|
      triangle = split_triangle(triangle)
      @count += 1 if valid_triangle?(triangle)
    end
  end

  def print_count
    puts "Valid triangles: #{@count}"
  end

  private

  def format_triangles(triangles)
    triangles.split("\n")
  end

  def split_triangle(triangle)
    triangle.split(" ")
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
