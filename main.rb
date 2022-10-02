class Game
  @@gameover = false

  def initialize(secret_code)
    @round = 1
    @secret_code = secret_code
  end

  def intro
    puts "------------------------------------------"
    puts "          WELCOME TO MASTERMIND           "
    puts "------------------------------------------"
    puts "New game? Y/N"
    yes_no = gets.to_s.strip.downcase
    
    if yes_no == 'y'
      play(@secret_code)
    elsif yes_no == 'n'
      exit
    else
      intro()
    end
  end

  def hide_code(code)
    code.map { |i| "X" }
  end

  def play(code)
    puts "=========================================="
    puts "code:"
    puts "   #{hide_code(code)}"
    puts "=========================================="

    while @@gameover != true
      puts "Round #{@round}:"
      choice = player_choice()
      puts "=========================================="
      check(code, choice)
      puts "=========================================="
    end

    puts "You Win!"
    puts "Secret code: #{code}"
    puts "=========================================="
  end

  def player_choice
    @round += 1
    arr_len = 4
    player_guess = Array.new

    arr_len.times do |i|
      puts "Choice #{i + 1}:"
      choice = gets.strip
      player_guess.push(choice)
    end

    puts "#{player_guess}"
    player_guess
  end

  def check(code, choice)
    score = Array.new
    hints = Array.new

    code.each_with_index do |v, i|
      if choice[i] == v
        score.push(true)
        hints.push("correct")
      elsif code.include?(choice[i]) == true
        score.push(false)
        hints.push("right color wrong spot")
      else
        score.push(false)
      end
    end

    if all_equal?(score) == true
      @@gameover = true
    end
    
    puts "#{hints.shuffle()}"
  end

  def all_equal?(score)
    score.uniq == [true]
  end

end

class CodeGen
  @@colors = ["purple", "red", "green", "blue", "gold", "orange"]
  def computer_code
    code = @@colors.sample(4)
    code
  end

  def player_code
  end
end

code = CodeGen.new
game = Game.new(code.computer_code)
game.intro


#create new game
#choose gamemode
#computer randomly generates 4 colors in specific order
#player guesses order and colors.
#computer tells player if a color is correct and in the correct place and if a color is correct but in the wrong place
#computer also says if a color is incorrect
#loop until player guesses correctly or 12 turns go by