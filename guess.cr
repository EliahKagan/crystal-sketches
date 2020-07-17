RIBS = [
  "Get your head in the game!",
  "What are you even doing?",
  "You're better than that!",
  "I knew you would disappoint.",
  "Are you even trying?",
  "Are these shenanigans deliberate?",
  "Is someone making you play this badly?",
  "That should never have happened.",
  "You are bad at this game.",
  "Delete your account! (Ctrl+D)"
]

def rib
  puts RIBS.sample
end

def rib(message)
  puts "#{message} #{RIBS.sample}"
end

class Game
  @try_count = 0
  @last_guess : Int32? = nil

  def initialize(@low : Int32, @goal : Int32, @high : Int32)
    raise "goal out of range" unless low <= goal <= high
    @guesses = Array(Int32).new(@high + 1, 0)
  end

  def do_guess(guess)
    @try_count += 1
    
    if guess == @goal
      pretty_count = (@try_count == 1 ? "just one try" : "#{@try_count} tries")
      puts "Correct! You guessed #{guess} in #{pretty_count}."
      return true
    end

    if guess == @last_guess
      puts "What?! I just told you #{guess} was wrong!"
    elsif guess < @low
      rib "#{guess} is lower than #{@low}."
    elsif guess > @high
      rib "#{guess} is higher than #{@high}."
    elsif @guesses[guess] == 1
      puts "You already guessed #{guess}."
    elsif @guesses[guess] == 2
      rib "You guessed #{guess} twice before."
    elsif @guesses[guess] > 2
      rib "You guessed #{guess} #{@guesses[guess]} times before!"
    else
      critique_strategy(guess)
    end

    @last_guess = guess
    false
  end

  private def critique_strategy(guess)
    if guess < @goal
      side = "low"
      range = (guess + 1)..(@goal - 1)
    elsif guess > @goal
      side = "high"
      range = (@goal + 1)..(guess - 1)
    else
      raise "Internal error: can't critique correct guess"
    end

    priors = range.reject { |guess| @guesses[guess].zero? }.to_a

    case priors.size
    when 0
      puts "No, #{guess} is too #{side}."
    when 1
      puts "Please. Even #{priors[0]} was too #{side}."
    when 2
      puts "Think about this. #{priors[0]} and #{priors[1]} were too #{side}."
    else
      pretty_priors = "#{priors[...-1].join(", ")} and #{priors[-1]}."
      puts "No. It's too #{side}, like #{pretty_priors}."
      rib
    end
  end
end

LOW = 1
HIGH = 100

puts "I'm thinking of a number from #{LOW} to #{HIGH}. " \
     "You're welcome to guess."

game = Game.new(LOW, (LOW..HIGH).sample, HIGH)

loop do
  print "? "
  line = gets

  if line.nil?
    puts "I accept that you forfeit the game."
    exit 1
  elsif (stripped = line.strip).empty?
    next
  elsif (guess = stripped.to_i?).nil?
    puts "Huh? (Please enter a number.)"
  elsif game.do_guess(guess)
    exit 0
  end
end
