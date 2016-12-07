class IpAddress
  def initialize(address_list)
    @address_list = format_address_list(address_list)
    @abba_list = create_abba_list
    @tls_count = 0
  end

  def run
    @address_list.each do |address|
      if supports_tls?(address)
        @tls_count += 1
      end
    end

    print_tls_count
  end

  private

  def abba_in_square_brackets?(address)
    sub_addresses = address.split("[")

    sub_addresses[1..-1].each do |subaddress|
      hypernet = subaddress.split("]").first

      return true if contains_abba?(hypernet)
    end

    false
  end

  def print_tls_count
    puts "#{@tls_count}"
  end

  def supports_tls?(address)
    contains_abba?(address) && !abba_in_square_brackets?(address)
  end

  def contains_abba?(address)
    @abba_list.each do |abba|
      return true if address.include?(abba)
    end

    false
  end

  def create_abba_list
    list = []

    ("a".."z").each do |letter|
      ("a".."z").each do |char|
        if letter != char
          list << "#{letter}#{char}#{char}#{letter}"
        end
      end
    end

    list
  end

  def format_address_list(address_list)
    address_list.split("\n")
  end
end
