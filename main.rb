class Game
  @@gameover = false
  @@computer_hints = Array.new

  def initialize(secret_code, colors)
    @round = 1
    @secret_code = secret_code
    @colors = colors
    @computer_guess = @colors.sample(4)
  end
#start intro
  def intro
    puts "------------------------------------------"
    puts "          WELCOME TO MASTERMIND           "
    puts "------------------------------------------"
    puts "New game? Y/N"
    yes_no = gets.to_s.strip.downcase
    
    if yes_no == 'y'
      puts "Pick a gamemode:"
      puts "1. Player as codemaker"
      puts "2. Computer as codemaker"
      mode = gets.to_i

      case mode
      when 1
        computer_play()
      when 2
        player_play(@secret_code)
      else
        puts "Please enter 1 or 2"
        intro()
      end

    elsif yes_no == 'n'
      exit
    else
      intro()
    end
  end
#hides secret code
  def hide_code(code)
    code.map { |i| "X" }
  end
#player picks colors for secret code
  def player_code_gen()
    code_len = 4
    player_code = Array.new

    puts "=========================================="
    puts "Pick 4 colors from the bank: #{@colors}"
    puts "=========================================="

    code_len.times do |i|
      puts "Choice #{i + 1}:"
      choice = gets.strip
      player_code.push(choice)
    end

    player_code
  end
#starts computer guess gamemode
  def computer_play()
    player_code = player_code_gen()
    puts "Your secret code: #{player_code}"

    while @@gameover != true
      puts "Round #{@round}"
      computer_choice = computer_choice()
      puts "------------------------------------------"
      computer_check(player_code, computer_choice)
      puts "#{@@computer_hints.shuffle()}"
      puts "=========================================="
      puts "\n"
      #if @round > 12
        #@@gameover = true
      #end
      @round += 1
    end

    if @round > 12
      puts "You Win!"
    else
      puts "Computer Wins!"
    end

    puts "Secret code: #{player_code}"
    puts "=========================================="

  end
#checks computers guesses
  def computer_check(player_code, computer_choice)
    score = Array.new
    @@computer_hints = Array.new

    player_code.each_with_index do |v, i|
      if computer_choice[i] == v
        score.push(true)
        @@computer_hints.push("correct")
      elsif player_code.include?(computer_choice[i]) == true
        score.push(false)
        @@computer_hints.push("right color wrong spot")
      else
        score.push(false)
      end
    end

    if all_equal?(score) == true
      @@gameover = true
    end
  end
#computer makes guesses
  def computer_choice()
    arr_len = 4
    count = 0

    if @round == 1
      @computer_guess = @colors.sample(arr_len)
    elsif @@computer_hints.include?("correct") == true
      @@computer_hints.each_with_index do |v, i|
        if v == "correct"
          count += 1
        end
      end
      @computer_guess = @computer_guess[0..count - 1]
      @computer_guess += @colors.sample(arr_len - count)
    else
      @computer_guess = @colors.sample(arr_len)
    end
    
    puts "#{@computer_guess}"
    @computer_guess
  end
#starts player guess gamemode
  def player_play(code)
    puts "=========================================="
    puts "code:"
    puts "   #{hide_code(code)}"
    puts "=========================================="

    while @@gameover != true
      puts "Color bank: #{@colors}"
      puts "Round #{@round}"
      choice = player_choice()
      puts "------------------------------------------"
      check(code, choice)
      puts "=========================================="
      puts "\n"
      if @round > 12
        @@gameover = true
      end
    end

    if @round > 12
      puts "Computer Wins!"
    else
      puts "You Win!"
    end

    puts "Secret code: #{code}"
    puts "=========================================="
  end
#allows player to input guesses
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
#checks players guesses
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
#checks if all colors are correct
  def all_equal?(score)
    score.uniq == [true]
  end

end
#generates computer's secret code
class CodeGen
  @@colors = ["purple", "red", "green", "blue", "gold", "orange"]

  def colors
    @@colors
  end

  def computer_code
    code = @@colors.sample(4)
    code
  end
end

code = CodeGen.new
game = Game.new(code.computer_code, code.colors)
game.intro


#create new game
#choose gamemode
#computer randomly generates 4 colors in specific order
#player guesses order and colors.
#computer tells player if a color is correct and in the correct place and if a color is correct but in the wrong place
#computer also says if a color is incorrect
#loop until player guesses correctly or 12 turns go by