require 'rspec'

def reverse_string(to_reverse="")
  return nil if to_reverse.nil?

  half = to_reverse.length / 2
  half.times do |i|
    first = to_reverse[i]
    to_reverse[i] = to_reverse[-i-1]
    to_reverse[-i-1] = first
  end

  to_reverse
end

describe "#reverse_string" do
  it "handles nil" do
    reverse_string(nil).should be_nil
  end

  it "handles empty strings" do
    reverse_string("").should == ""
  end

  it "handles strings with multiple repeating characters" do
    reverse_string("    ").should == "    "
    reverse_string("aaaa").should == "aaaa"
  end

  it "actually reverses the string" do
    reverse_string("donkey").should == "yeknod"
  end
end
