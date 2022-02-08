
class Column
  attr_reader :name, :index, :count

  def initialize(name, index, count = 0)
    @name = name
    @index = index
    @count = count
  end
end
