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
      end
    end

    def play(piece:, column:)
      return false if out_of_bounds(column)
    end

    def out_of_bounds(column)
      column < 1 || column > @columns
    end
  end
end
