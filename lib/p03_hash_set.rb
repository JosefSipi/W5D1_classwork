class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if count + 1 > num_buckets
      resize!
    end
    self[key] << key
    @count += 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
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
