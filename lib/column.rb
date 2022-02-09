
class Column
  attr_reader :name, :index, :count

  def initialize(name, index, count = 0)
    @name = name
    @index = index
    @count = count
  end
end

#name is equal to the "letter" string to match with user input for placement
#index is for which column the piece gets dropped into, each letter has a set index 0-6
#the count starts at 0 since the columns are empty and increases by one each time there is a pieced dropped into it
