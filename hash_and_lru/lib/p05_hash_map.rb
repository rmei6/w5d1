require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    list = @store[bucket(key)]
    if list.include?(key)
      list.update(key,val)
    else
      resize! if count >= num_buckets
      list.append(key,val)
      @count += 1
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    if include?(key)
      @store[bucket(key)].remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |list|
      list.each do |node|
        yield [node.key,node.val]
      end
    end
  end

  #uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    new_store = Array.new(new_num_buckets) {LinkedList.new}
    @store.each do |list|
      list.each do |node|
        key = node.key
        new_store[key.hash % new_num_buckets].append(key,node.val)
      end
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
