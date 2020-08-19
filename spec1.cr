require "spec"

describe Array do
  describe "#[]" do
    it "indexes backward from the end with negative subscripts" do
      a = %w[Alice Bob Cassidy]
      a[-1].should eq "Cassidy"
      a[-2].should eq "Bob"
      a[-3].should eq "Alice"
      a[0].should eq "Derek" # will fail
    end
  end
end
