class MaxIntSet
  attr_reader :store
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    if validate!(num)
      @store[num] = true
    end
  end

  def remove(num)
    if validate!(num)
      @store[num] = false
    end
  end

  def include?(num)
    @store[num]  
  end

  private

  def is_valid?(num)
    if num > @max - 1
      return false
    elsif num < 0
      return false
    end
    return true
  end

  def validate!(num)
    if is_valid?(num)
      return true
    else
      raise "Out of bounds"
    end
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
    end

  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if count + 1  > num_buckets
      resize!
    end
    if !include?(num)
      self[num] << num
      @count += 1
    end
    
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_arr = []
    @store.each do |bucket|
      new_arr += bucket
    end

    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    new_arr.each do |ele|
      insert(ele)
    end
  end
end
