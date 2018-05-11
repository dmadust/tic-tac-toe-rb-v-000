# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8],
  [0, 3, 6], [1, 4, 7], [2, 5, 8],
  [0, 4, 8], [2, 4, 6]]
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def position_took?(space)
  !(space.nil? || space == " ")
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end
  
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    position0 = board[combo[0]]
    position1 = board[combo[1]]
    position2 = board[combo[2]]
    
    if (position0 == "X" && position1 == "X" && position2 == "X") ||
      (position0 == "O" && position1 == "O" && position2 == "O")
      return combo
    end
  end
  return nil
end

def full?(board)
  board.all?{|space| position_took?(space)}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  winning_combo = won?(board)
  if (!winning_combo.nil?)
    board[winning_combo[0]]
  else
    nil
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  until valid_move?(board, index)
    input = gets.strip
    index = input_to_index(input)
  end
  move(board, index, current_player(board))
  display_board(board)
end

def turn_count(board)
  count = 0 
  board.each do |space|
    if position_took?(space)
      count += 1 
    end
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def play(board)
  until over?(board)
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end