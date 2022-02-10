require 'rspec'
require './lib/column'

describe Column do
  describe 'initialize' do
    A = Column.new("A", 0)
    B = Column.new("B", 1)
    it 'exists' do
      # A = Column.new("A", 0)
      expect(A).to be_an_instance_of(Column)
    end

    it 'has a name' do
      # A = Column.new("A", 0)
      expect(A.name).to eq("A")
    end

    it 'has an index' do
      # B = Column.new("B", 1)
      expect(B.index).to eq(1)
    end

    it 'has a default count of 0' do
      # B = Column.new("B", 1)
      expect(B.count).to eq(0)
    end
  end
end
