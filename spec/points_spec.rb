require './lib/points'

describe Points do
  let(:points) { Points.new(2, :rule_code) }

  it 'has points and message when initialized' do
    points.value.should eq 2
    points.rule_code.should eq :rule_code 
  end
end