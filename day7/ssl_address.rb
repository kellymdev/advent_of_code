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
    bab_list = bab_inside_square_brackets(address)

    aba_outside_square_brackets?(address, bab_list) if !bab_list.empty?
  end

  def bab_inside_square_brackets(address)
    sub_addresses = address.split("[")

    bab_list = []

    sub_addresses[1..-1].each do |subaddress|
      hypernet = subaddress.split("]").first

      bab_list += contains_bab(hypernet)
    end

    return bab_list
  end

  def aba_outside_square_brackets?(address, bab_list)
    bab_list.each do |bab|
      corresponding_aba = @aba_list.key(bab)

      sub_addresses = address.split("]")

      sub_addresses[0..-1].each do |subaddress|
        supernet = subaddress.split("[").first

        return true if corresponding_aba && contains_aba?(supernet, corresponding_aba)
      end
    end

    false
  end

  def contains_bab(hypernet)
    bab_list = []

    @aba_list.values.each do |bab|
      bab_list << bab if hypernet.include?(bab)
    end

    bab_list
  end

  def contains_aba?(supernet, aba)
    supernet.include?(aba)
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
