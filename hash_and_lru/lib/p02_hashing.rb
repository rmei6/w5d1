class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    self.inject(0.hash) {|acc,num| acc = acc.hash ^ num.hash}
  end
end

class String
  def hash
    arr = self.split("").to_a
    arr.map! {|char| char.ord}
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    #0
    sorted = self.sort.to_h
    key_hash = sorted.keys.map{|ele| ele.to_s.ord}.hash
    value_hash = sorted.values.map{|ele| ele.to_s.ord}.hash
    key_hash + value_hash   #examples make key_hash and value_hash equal
  end
end
