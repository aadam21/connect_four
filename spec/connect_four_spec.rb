require "connect_four"

RSpec.describe ConnectFour do
  it "has a version number" do
    expect(ConnectFour::VERSION).not_to be nil
  end
end
