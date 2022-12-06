class PriorityQueue(T)
  def initialize
    @values = [] of T
    @priorities = [] of Int32
  end

  def add_with_priority(val : T, priority : Int32)
    @values << val
    @priorities << priority
  end

  def decrease_priority(val : T, new_priority : Int32)
    if index = @values.index(val)
      @priorities[index] = new_priority
    end
  end

  def extract_min
    if min_index = @priorities.index(@priorities.min)
      min_val = @values[min_index]
      @values.delete_at(min_index)
      @priorities.delete_at(min_index)
      min_val
    end
  end

  forward_missing_to @values
end

# example usage
# queue = PriorityQueue(String).new
# queue.add_with_priority("A", 2)
# queue.add_with_priority("B", 1)
# queue.add_with_priority("C", 3)
# queue.decrease_priority("C", 0)
# puts queue.extract_min # output: "C"
# puts queue.extract_min # output: "A"
# puts queue.extract_min # output: "B"
