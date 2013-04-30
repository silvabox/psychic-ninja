require './lib/rule.rb'

describe Rule do
  let(:context) { double :context }
  
  let(:rule) { Rule.new(context) }
  
  describe '.new' do
    it 'is initialized with a context' do
      rule.context.should eq context
    end

    it 'has 0 points' do
      rule.points.should eq 0
    end
  end

  describe '#run' do
    it 'returns false' do
      rule.run.should be_false
    end
  end
end