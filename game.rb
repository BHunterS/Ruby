def play_game(player, computer)
    if player == computer
        return "It's a tie"   
    elsif (player == "stone" && computer == "scissors") ||
        (player == "scissors" && computer == "paper") ||
        (player == "paper" && computer == "stone")
        return "You win"
    else
        return "You lose"
    end
end

if ARGV.length != 2
    puts "Too many argumantes"
else
    correct_arguments = ["stone", "paper", "scissors"]
    player = ARGV[0].downcase
    computer = ARGV[1].downcase

    if correct_arguments.include?(player) && correct_arguments.include?(computer)    
        puts play_game(player, computer) 
    else 
        puts "Incorrect arguments"
    end
end