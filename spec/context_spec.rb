require './lib/context.rb'

describe Context do 
  let(:context) { Context.new }

  it 'allow initialization with a hash' do
    context = Context.new ({ item1: :value1, item2: :value2 })
    context[:item1].should eq :value1
    context[:item2].should eq :value2
  end
  it 'allows a context item to be set' do

  end
end