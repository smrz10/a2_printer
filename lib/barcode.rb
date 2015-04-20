class Barcode

  def initialize connection
    @connection = connection
  end

  def set_height(height)
    @connection.write_bytes(29, 104, height)
  end
  alias_method :set_barcode_height, :set_height

  def print(text, type)
    set_type type
    print text
    end_print
  end
  alias_method :print_barcode, :print

  private
  def set_type type
    @connection.write_bytes(29, 107, type)
  end

  def print text
    text.bytes { |b| @connection.write(b) }
  end

  def end_print
    @connection.write(0)
  end
end
