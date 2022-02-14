
class Cell
  attr_reader :row, :column, :occupied, :display
  attr_accessor :occupied, :display

  def initialize(row, column, occupied = false, display = ". ")
    @display = display
    @row = row
    @column = column
    @occupied = occupied
  end

  def occupy(letter)
    @display = letter
    @occupied = true
  end


end
