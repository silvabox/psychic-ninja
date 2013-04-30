class Rule
  attr_reader :context, :points

  def initialize(context)
    @context = context
    @points = 0
  end

  def run
    false
  end
end