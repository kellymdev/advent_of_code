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

  def abba_in_square_brackets?(address)
    hypernet = ""
    brace_count = number_of_opening_square_braces(address)

    sub_addresses = address.split("[")

    sub_addresses[1..-1].each do |subaddress|
      hypernet = subaddress.split("]").first

      return true if contains_abba?(hypernet)
    end

    false
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
  end

  def format_address_list(address_list)
    address_list.split("\n")
  end
end
