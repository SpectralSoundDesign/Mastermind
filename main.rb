class Game
  def initialize(secret_code)
    @round = 1
    @secret_code = secret_code
  end

  def intro
    puts "---------------------"
    puts "WELCOME TO MASTERMIND"
    puts "---------------------"
    puts "New game? Y/N"
    yes_no = gets
    #fix later
    if yes_no == "y" || yes_no == "Y" || yes_no == "n" || yes_no == "N"
      puts "test"
    end
  end

  def play(yes_no)
    puts "test"
  end

  def display
    puts @secret_code
  end

  def player_choice
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