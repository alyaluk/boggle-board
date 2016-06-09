# You should re-use and modify your old BoggleBoard class
# to support the new requirements

class BoggleBoard
    def initialize
        @letters = ('A'..'Z').to_a.map! { |x| x == "Q" ? "Qu" : x }
        @new_board = [["New board:"],
        ["_ _ _ _"],
        ["_ _ _ _"],
        ["_ _ _ _"],
        ["_ _ _ _"]]
        puts @new_board
        @dice = []
        16.times do @dice << @letters.sample(6) end
    end
    
    def shake!
        @new_board = [[""],
        ["Shook the board!"]]
        @selected_dice = Array.new(4)
        @selected_array = []
        x = 0
        for i in (0..3)
            x += 1
            letter_1 = @dice[x].sample
            letter_2 = @dice[x+1].sample
            letter_3 = @dice[x+2].sample
            letter_4 = @dice[x+3].sample
            @selected_array << letter_1
            @selected_array << letter_2
            @selected_array << letter_3
            @selected_array << letter_4
            @selected_dice[i] = ["#{letter_1} #{letter_2} #{letter_3} #{letter_4}"]
        end
        @new_board << @selected_dice
        puts @new_board
    end
    
    def to_include?(word)
        split_word = word.split("")
        split_word.each {|q| q.sub!("Q","Qu")}
        word.sub!("Q", "Qu")
        counter = 0
        split_word.each do |x|
            @selected_array.each do |y|
                word.sub!(x,"0") if x == y
            end
        end
        if word.split("").count("0") == split_word.length
            return true
            else
            return false
        end
    end
    
    def to_s; " "; end
end

board = BoggleBoard.new
puts board
board.shake!

answer = nil
until answer == "quit"
    puts ""
    puts "Shake board or input word or quit? (shake/word/quit)"
    answer = gets.chomp
    board.shake! if answer == "shake"
    if answer == "word"
        puts ""
        puts "What's your word?"
        word_check = gets.chomp
        puts board.to_include?(word_check.downcase.sub("qu", "q").upcase) ? "Nice word!" : "Your word's not there!"
    end
end