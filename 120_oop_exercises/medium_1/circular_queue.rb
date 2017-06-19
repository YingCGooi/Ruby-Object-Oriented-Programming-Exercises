class CircularQueue
  attr_reader :buffer, :max_buffer_size

  def initialize(max_buffer_size)
    @max_buffer_size = max_buffer_size
    @buffer = Hash.new
    @order = 0
  end

  def dequeue
    oldest = buffer.keys.min
    buffer.delete(oldest)
  end

  def enqueue(value)
    dequeue if buffer.size >= max_buffer_size
    @order += 1
    buffer[@order] = value
  end
end


# Examples:

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2
p queue.buffer

queue.enqueue(5)
p queue.buffer
queue.enqueue(6)
p queue.buffer
queue.enqueue(7)
p queue.buffer
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
p queue.buffer
queue.enqueue(2)
p queue.buffer
puts queue.dequeue == 1

queue.enqueue(3)
p queue.buffer
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil