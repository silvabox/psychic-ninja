class Context
  def initialize(hash = {})
    @hash = {}
    @hash.concat hash
  end

  def [](item)
    @hash[item]
  end
end