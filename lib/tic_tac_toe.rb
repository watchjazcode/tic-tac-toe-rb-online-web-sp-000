def turn_count(board) #method that determines how many turns have been played
  counter = 0 #starts at 0 and is how many turns have been played so far
  #this is what board will look like, but will not be run
  #board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  board.each do |space| #checking each space individually
    if space == "X" || space == "O"
      counter += 1 #everytime we look at ea space, if taken we played one turn
    end
  end
  return counter
end


def current_player(board)
  if turn_count(board).even?
    return "X"
  else #if even returns X 
    return "O"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
]

# iterates nested array win_combinations and determines if 
# the same character is in all three spots for the combination
# returns one of the win_combinations lines
def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  return nil
end

#determines if the board is full
def full?(board)
  board.each do | board_cell |
    if board_cell == " " || board_cell == "" || board_cell == nil
      return false
    end
  end
  return true
end

# true if the board has not been won, but is full
# false if the board has not been won, and not full
# false if the board is won
def draw?(board)
  if !won?(board)
    if full?(board)
      return true
    else
      return false
    end
  else won?(board)
    false
  end
end

#accepts a board and returns true if board is won, is a draw, or is full
def over?(board)
  if full?(board) || won?(board) || draw?(board)
    return true
  end
end

# method accepts a board and returns the token X or O that has won the game.
def winner(board)
  result = won?(board) # asking if there is a win
  if result == nil # if no winner
    return nil
  else
    index = result[0] #take array (win_combination) check one of the spaces
    return board[index] # return index character, which determines all 3 positions
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  until valid_move?(board, index)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
  move(board, index, current_player(board))
  display_board(board)
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    winner_winner_chicken_dinner = won?(board)
    if winner_winner_chicken_dinner == true
      puts "Congratulations"
    else
      character = board[winner_winner_chicken_dinner[0]]
      puts "Congratulations #{character}!"
    end
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
  

