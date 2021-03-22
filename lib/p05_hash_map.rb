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
  end

  def each(&prc)
  # debugger
    i = 0
    while i < num_buckets
      @store[i].each do |node|
        if node != self.head && node != self.tail
          prc.call(node.key, node.value)
        end
      end
      i += i
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
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
