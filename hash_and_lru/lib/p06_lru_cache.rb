require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)     #key in map
      node = @map.get(key)
      update_node!(node)
      return node.val
    else
      value = @prc.call(key)
      node = @store.append(key,value)
      @map.set(key,node)
      if @map.count > @max
        eject!
      end
      return value
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)      
    # suggested helper method; insert an (un-cached) key
    value = @prc.call(key)
    node = @store.append(key,value)
    @map.set(key,node)
    if @map.count > @max
      eject!
    end
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.append(node.key,node.val)
    @store.remove(node.key)
  end

  def eject!
    key = @store.first.key
    @store.first.remove
    @map.delete(key)
  end
end
