module ConnectFour
  class Board
    attr_reader :rows, :columns, :cells

    def initialize(rows: 6, columns: 7, state: nil)
      if state.is_a?(Board)
        @rows, @columns = state.rows, state.columns
        @cells = empty_cells(@columns)
        @columns.times do |column|
          @rows.times do |row|
            @cells[column][row] = state.cells[column][row] if state.cells[column][row]
          end
        end
      else
        @rows, @columns = rows, columns
        @cells = empty_cells(@columns)
      end
    end

    def play(piece:, column:)
      return false if out_of_bounds(column)
      return false if full_column?(column)
      return if winner?
      @cells[column - 1].push piece
    end

    def out_of_bounds(column)
      column < 1 || column > @columns
    end

    def full_column?(column)
      @cells[column - 1].length >= @rows
    end

    def winner? #TODO: Break this monster apart and make more readable
      @columns.times do |column|
        @rows.times do |row|
          unless (piece = @cells[column][row]).nil?
            return piece if (row <= (@rows - 4)) && [piece, @cells[column][row + 1],
                                                     @cells[column][row + 2],
                                                     @cells[column][row + 3]].uniq.length == 1
            return piece if (column <= (@columns - 4)) && [piece, @cells[column + 1][row],
                                                           @cells[column + 2][row],
                                                           @cells[column + 3][row]].uniq.length == 1
            return piece if (row <= (@rows - 4)) && (column <= (@columns - 4)) && [piece, @cells[column + 1][row + 1],
                                                                                        @cells[column + 2][row + 2], @cells[column + 3][row + 3]].uniq.length == 1
            return piece if (row >= 3) && (column <= (@columns - 4)) && [piece, @cells[column + 1][row - 1], @cells[column + 2][row - 2], @cells[column + 3][row - 3]].uniq.length == 1
          end
        end
      end
      false
    end

    def valid_moves
      (0...@columns).to_a.reject{ |x| @cells[x].length == @rows }.map{ |x| x + 1 }
    end

    def make_move(piece:, depth: 6)   #TODO: Definitely needed some Google help on this one; hope to have time to revisit
      valid_moves.reduce({}) do |scores, column|
        prospective_board = Board.new(state: self) # Clone board in current state
        prospective_board.play(piece: piece, column: column)

        if prospective_board.winner?
          scores[column] = (prospective_board.winner? == piece) ? 1 : -1
        elsif depth > 1
          computers_piece = (piece == "X" ? "O" : "X")
          next_move_scores = prospective_board.make_move(piece: computers_piece, depth: depth - 1).values
          average = next_move_scores.reduce(:+).to_f / next_move_scores.length
          scores[column] = -1 * average
        else
          scores[column] = 0
        end
        scores
      end
    end

    #Print board
    def to_s
      result  = "+#{'---+'*@columns}\n"
      result << "|#{@columns.times.map{|column|"#{ (column + 1).to_s.center(3) }|"}.join}\n" # Print column numbers centered in topmost cells
      result << "+#{ '---+'*@columns }\n"
      @rows.times do |r|
        result << "|#{@columns.times.map{ |column|"#{ @cells[column][@rows - r - 1].to_s.center(3) }|" }.join}\n"
        result << "+#{'---+'*@columns}\n"
      end
      result
    end

      private

      def empty_cells(columns)
        columns.times.map { [] }
      end
  end
end
