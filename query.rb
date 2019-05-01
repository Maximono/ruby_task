class Query
  attr_reader :result

  def initialize
    @result = {}
  end

  def sort(*options)
    options_hash = Hash.new { |options_hash, key| options_hash[key] = :asc }
    options.each do |element|
      element.is_a?(Hash) ? options_hash.merge!(element) : options_hash[element]
    end

    result.has_key?(:sort) ? @result[:sort].merge!(options_hash) : result[:sort] = options_hash
    self
  end

  def size(arg)
    arg.is_a?(Integer) ? @result[:size] = arg : raise(TypeError, 'wrong argument type')
    self
  end

  def from(arg)
    arg.is_a?(Integer) ? @result[:from] = arg : raise(TypeError, 'wrong argument type')
    self
  end
end
