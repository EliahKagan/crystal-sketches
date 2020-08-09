class Factory(T)
  def initialize(&@producer : -> T)
  end

  def call
    @producer.call
  end
end

count = 0
factory = Factory(String).new { "Hello, ##{count += 1}!" }
3.times { puts factory.call }
