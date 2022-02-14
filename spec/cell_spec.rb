require 'rspec'
require './lib/cell'

describe Cell do
  describe '#initialize' do
    it 'exists' do
      cell = Cell.new(0, 0)
      expect(cell).to be_an_instance_of(Cell)
    end

    it 'has a row' do
      cell = Cell.new(1, 0)
      expect(cell.row).to eq(1)
    end

    it 'has a column' do
      cell = Cell.new(1, 0)
      expect(cell.column).to eq(0)
    end

    it 'starts out unoccupied' do
      cell = Cell.new(1, 0)
      expect(cell.occupied).to be false
    end

    it "has starts with a display of '. ' " do
      cell = Cell.new(1, 0)
      expect(cell.display).to eq(". ")
    end
  end

  describe "#occupy" do
    it 'can be occupied and change display' do
      cell = Cell.new(1, 0)
      cell.occupy("X ")
      expect(cell.display).to eq("X ")
      expect(cell.occupied).to be true
      cell.occupy("O ")
      expect(cell.display).to eq("O ")
      expect(cell.occupied).to be true
    end
  end
end
