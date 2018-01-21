#!/usr/bin/env ruby
require "bundler/setup"
require_relative "connect_four/board.rb"

# module ConnectFour
#   # Your code goes here...
# end
include ConnectFour

board = Board.new
player = "X"
last_computer_move = nil
print `clear`
print "How hard do you want the competition? Choose (0 - 6)"
difficulty = gets.strip.to_i

until board.valid_moves.empty? || board.winner?
  if player == "O"
    print `clear`
    puts "Considering how to clobber you..."
    puts board
    possible_next_moves = board.make_move(piece: player, depth: difficulty)
    best_move = possible_next_moves.sort_by{ |k, v| [v, rand{}] }.last[0]
    board.play piece: player, column: best_move
    last_computer_move = "I played in column #{best_move}."
  else
    print `clear`
    puts last_computer_move
    puts board
    valid_move = false
    until valid_move
      c = gets.strip.to_i
      valid_move = board.play piece: player, column: c
    end
  end
  player = (player == "X" ? "O" : "X")
end

if board.winner?
  if board.winner? == "O"
    puts "'#{board.winner?}' clobbered you!"
  else
    puts "'#{board.winner?}' got lucky this time..."
  end
else
  puts "It's a tie."
end
puts board
