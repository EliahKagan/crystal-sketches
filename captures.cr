actions = [] of Proc(Nil)
(1..5).each { |i| actions << ->{ puts "#{i} squared is #{i**2}." } }
actions.each &.call
