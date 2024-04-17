class Board
    attr_accessor :cells
  
    def initialize
      @cells = Array.new(3) { Array.new(3, ' ') }
    end
  
    def display_board
      @cells.each_with_index do |row, index|
        puts row.join(' | ')
        puts "--+---+--" unless index == 2
      end
    end
  
    def place_mark(row, col, mark)
      if @cells[row][col] == ' '
        @cells[row][col] = mark
      else
        puts "Invalid move! Cell already taken."
      end
    end
  
    def check_winner(mark)
      # Check rows, columns, and diagonals for a winning condition
      @cells.any? { |row| row.all? { |cell| cell == mark } } ||
      @cells.transpose.any? { |col| col.all? { |cell| cell == mark } } ||
      [@cells[0][0], @cells[1][1], @cells[2][2]].all? { |cell| cell == mark } ||
      [@cells[0][2], @cells[1][1], @cells[2][0]].all? { |cell| cell == mark }
    end
  end
  
  class Player
    attr_reader :name, :mark
  
    def initialize(name, mark)
      @name = name
      @mark = mark
    end
  end
  
 #game
  board = Board.new
  player1 = Player.new("Player 1", 'X')
  player2 = Player.new("Player 2", 'O')
  
  current_player = player1
  
  puts "Let's play a game of Tic Tac Toe!...are you ready?"
  #prompt for either player 1 or player 2 responses and display their results
  loop do
    board.display_board
    puts "#{current_player.name}'s turn. Enter row 't'/ m'/'b' (Top, Middle, Bottom):"
    rowChoice = gets.chomp
    puts "Enter column 'l'/'m'/'r' (Left, Middle, Right):"
    colChoice = gets.chomp
    row = case rowChoice.downcase
          when 't' then 0
          when 'm' then 1
          when 'b' then 2
          else 
            puts "Incorrect row choice try again, please choose from: 't', 'm', or 'b'."
            rowChoice = gets.chomp
          end
    col = case colChoice.downcase
          when 'l' then 0
          when 'm' then 1
          when 'r' then 2
          else 
            puts "Incorrect column choice try again, please choose from: 'l', 'm', or 'r'"
            colChoice = gets.chomp
          end    
      
    board.place_mark(row, col, current_player.mark)
  #if 3 in a row it will display winner using the #check_winner method
    if board.check_winner(current_player.mark)
      board.display_board
      puts "#{current_player.name} wins!"
      break
    end
  
    unless board.cells.flatten.include?(' ')
      board.display_board
      puts "It's a tie!"
      break
    end
    #change players
    current_player = (current_player == player1) ? player2 : player1
  end