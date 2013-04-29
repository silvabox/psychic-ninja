require './lib/rule.rb'

describe Rule do
  it 'is initialized with a context' do
    context = double :context
    rule = Rule.new(context)
    rule.context.should eq context
  end
end