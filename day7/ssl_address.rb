class SslAddress
  def initialize(address_list)
    @address_list = format_address_list(address_list)
    @aba_list = create_aba_list
    @ssl_count = 0
  end

  def run
    @address_list.each do |address|
      if supports_ssl?(address)
        @ssl_count += 1
      end
    end

    print_ssl_count
  end

  private

  def supports_ssl?(address)
    bab = bab_inside_square_brackets(address)

    aba_outside_square_brackets?(address, bab) if bab
  end

  def bab_inside_square_brackets(address)
    hypernet = ""
    brace_count = number_of_opening_square_braces(address)

    sub_addresses = address.split("[")

    sub_addresses[1..-1].each do |subaddress|
      hypernet = subaddress.split("]").first

      bab = contains_bab(hypernet)

      return bab
    end
  end

  def aba_outside_square_brackets?(address, bab)
    corresponding_aba = @aba_list.key(bab)
    substring = ""
    brace_count = number_of_opening_square_braces(address)

    sub_addresses = address.split("]")

    sub_addresses[0..-1].each do |subaddress|
      substring = subaddress.split("[").first

      return true if corresponding_aba && contains_aba?(substring, corresponding_aba)
    end

    false
  end

  def contains_bab(hypernet)
    @aba_list.values.each do |bab|
      return bab if hypernet.include?(bab)
    end
  end

  def contains_aba?(substring, aba)
    substring.include?(aba)
  end

  def number_of_opening_square_braces(address)
    brace_count = 0

    address.chars.each do |char|
      if opening_square_brace?(char)
        brace_count += 1
      end
    end

    brace_count
  end

  def opening_square_brace?(char)
    char == "["
  end

  def print_ssl_count
    puts "#{@ssl_count}"
  end

  def create_aba_list
    list = {}

    ("a".."z").each do |letter|
      ("a".."z").each do |char|
        if letter != char
          aba = "#{letter}#{char}#{letter}"
          bab = "#{char}#{letter}#{char}"

          list[aba] = bab
        end
      end
    end

    list
  end

  def format_address_list(address_list)
    address_list.split("\n")
  end
end
