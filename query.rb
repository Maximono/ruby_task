require 'json'

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

    if @result[:sort]
      @result[:sort].merge!(options_hash)
    else
      result[:sort] = options_hash
    end

    self
  end

  def size(arg)
    if arg.is_a?(Integer)
      @result[:size] = arg
    else
      raise(TypeError, 'wrong argument type')
    end

    self
  end

  def from(arg)
    if arg.is_a?(Integer)
      @result[:from] = arg
    else
      raise(TypeError, 'wrong argument type')
    end

    self
  end

  def filter(options_hash = {})
    if @result[:query]
      @result[:query].merge!(options_hash)
    else
      result[:query] = options_hash
    end

    self
  end

  def to_json
    result.to_json
  end
end
