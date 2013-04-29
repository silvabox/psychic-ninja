class Points
  attr_reader :value, :rule_code

  def initialize(value, rule_code)
    @value, @rule_code = value, rule_code
  end
end