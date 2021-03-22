require_relative 'p04_linked_list'
require "byebug"
class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    self.each do |k, v|
      return true if k == key
    end
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key, val)
    else
      if count + 1 > num_buckets
        resize!
      end
      bucket(key).append(key, val)
      @count += 1
    end

  end

  def get(key)
    if include?(key)
      self.each do |k,v|
        return v if k == key 
      end
    else
      return nil
    end
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each(&prc)
  # debugger
    i = 0
    while i < num_buckets
      @store[i].each do |node|
        prc.call(node.key, node.val)
      end
      i += 1
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_arr = []
    self.each do |k,v|
      new_arr << [k,v]
    end
    @store = Array.new(num_buckets * 2) { LinkedList.new } 
    @count = 0
    new_arr.each do |sub|
      k = sub[0]
      v = sub[1]
      self.set(k,v)
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
