class FileToArray
  attr_reader :array,:file
  def initialize(file)
    @file = file.open
  end

  def to_run(&block)
    Product.update_all(units: 0)
    @file.each_slice(1) do |big_block|
      array = big_block.map{|x| array_to_hash(x) }
      block.call(array)
    end
  end

  def array_to_hash(line)
    line = line.encode!('UTF-8',:undef => :replace, :invalid => :replace, :replace => "")
    line.split("\t")
  end

  def encoding(line)
    Iconv.new('UTF8','LATIN1')
  end
end
