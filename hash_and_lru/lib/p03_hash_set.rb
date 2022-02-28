class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count >= num_buckets
    hash = key.hash
    unless include?(key)
      self[hash] << key
      @count += 1
    end
  end

  def include?(key)
    hash = key.hash
    return false unless self[hash].include?(key)
    true
  end

  def remove(key)
    hash = key.hash
    if include?(key)
      self[hash].delete(key) 
      @count -= 1
    end
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
    new_num_buckets = num_buckets * 2
    new_store = Array.new(new_num_buckets) {Array.new}
    @store.each do |bucket|
      bucket.each do |num|
        new_store[num.hash % new_num_buckets] << num
      end
    end
    @store = new_store
  end
end
