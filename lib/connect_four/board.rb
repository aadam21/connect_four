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
                                                     @cells[column][row + 3].uniq.length == 1
            return piece if (column <= (@columns - 4)) && [piece, @cells[column + 1][row],
                                                           @cells[column + 2][row],
                                                           @cells[column + 3][row]].uniq.length == 1
            return piece if (r <= (@rows - 4)) && (column <= (@columns - 4)) && [piece, @cells[column + 1][row + 1],
                                                                                        @cells[column + 2][row + 2], @cells[column + 3][row + 3]].uniq.length == 1
            return piece if (r >= 3) && (column <= (@columns - 4)) && [piece, @cells[column + 1][row - 1], @cells[column + 2][row - 2], @cells[column + 3][row - 3]].uniq.length == 1
          end
        end
      end
      false
    end

    def valid_moves
      (0...@columns).to_a.reject{ |x| @cells[x].length == @rows }.map{ |x| x + 1 }
    end

      private

      def empty_cells(columns)
        columns.times.map { [] }
      end
  end
end
