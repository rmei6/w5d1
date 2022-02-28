class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    prev.next = self.next
    self.next.prev = prev
  end
end

class LinkedList
  include Enumerable
  attr_reader :head,:tail
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail
  end

  def get(key)
    start = head
    until start == tail
      return start.val if start.key == key
      start = start.next
    end
    nil
  end

  def include?(key)
    start = head
    until start == tail
      return true if start.key == key
      start = start.next
    end
    false
  end

  def append(key, val)
    start = head
    until start.next == tail
      start = start.next
    end
    new_node = Node.new(key,val)
    start.next = new_node
    new_node.prev = start
    new_node.next = tail
    tail.prev = new_node
    new_node
  end

  def update(key, val)
    start = head
    until start.key == key || start == tail
      start = start.next
    end
    start.val = val unless start == tail
  end

  def remove(key)
    start = head
    until start.key == key
      start = start.next
    end
    start.remove
  end

  def each
    start = head.next
    until start == tail
      yield start
      start = start.next
    end
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
