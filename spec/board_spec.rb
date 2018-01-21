require "spec_helper"

include ConnectFour

module ConnectFour
  RSpec.describe Board do
    let(:board) { Board.new }
    let(:existing_state) { Board.new({ rows: 10, columns: 12 }) }

    context "#initialize" do
      it "defaults to six rows" do
        expect(board.rows).to eq(6)
      end

      it "defaults to seven columns with no previous state" do
        expect(board.columns).to eq(7)
      end

      it "builds appropriate rows and columns based on state if present" do
        expect(existing_state.rows).to eq(10)
        expect(existing_state.columns).to eq(12)
      end

      it "has all empty cells" do
        expect(board.cells).to all(be_empty)
      end
    end

    context "#play" do
      it "does not allow a play out of bounds" do
        expect(board.play(piece: "X", column: 10)).to be false
      end

      it "does not allow a play in a full column" do
        # TODO: Work on a good test for this *** `expect(board.full_column?(6)).to be false`
      end
    end
  end
end
