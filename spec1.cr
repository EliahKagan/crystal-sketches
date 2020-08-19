require "spec"

describe Array do
  describe "Does this have to be a real method name?" do
    it "indexes backward from the end with negative subscripts" do
      a = %w[Alice Bob Cassidy]
      a[-1].should eq "Cassidy"
      a[-2].should eq "Bob"
      a[-3].should eq "Alice"
    end
  end
end
