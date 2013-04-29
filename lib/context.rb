class Context
  def initialize(hash = {})
    @hash = {}
    @hash.merge! hash
  end

  def [](item)
    @hash[item]
  end

  def []=(item, value)
    @hash[item] = value
  end
end