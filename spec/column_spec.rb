require 'rspec'
require './lib/column'

describe Column do
  describe 'initialize' do
    a = Column.new("A", 0)
    b = Column.new("B", 1)
    it 'exists' do
      expect(a).to be_an_instance_of(Column)
    end

    it 'has a name' do
      expect(a.name).to eq("A")
    end

    it 'has an index' do
      expect(b.index).to eq(1)
    end

    it 'has a default count of 0' do
      expect(b.count).to eq(0)
    end
  end
end
