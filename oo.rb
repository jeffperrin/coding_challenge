require 'rspec'

class Grade
  include Comparable
  VALID_GRADES = %w(F D- D D+ C- C C+ B- B B+ A- A)

  def initialize(letter)
    raise ArgumentError.new("Letter grade can't be nil") if letter.nil?
    @letter = letter.to_s.upcase

    unless VALID_GRADES.include?(@letter)
      raise ArgumentError.new("#{letter} is not a valid letter grade")
    end
  end

  def <=>(other_grade)
    other_rank = VALID_GRADES.index(other_grade.to_s)
    rank = VALID_GRADES.index(to_s)
    rank <=> other_rank
  end

  def to_s
    @letter
  end
end

describe Grade do
  describe "#initialize" do
    it "raises an error when a nil letter grade is given" do
      lambda{ Grade.new(nil) }.should raise_error(ArgumentError, /can't be nil/)
    end

    it "accepts all proper letter grades in upper case" do
      acceptable_grades = %w(F D- D D+ C- C C+ B- B B+ A- A)
      acceptable_grades.each do |grade|
        Grade.new(grade)
      end
    end

    it "accepts all proper letter grades in lower case" do
      acceptable_grades = %w(f d- d d+ c- c c+ b- b b+ a- a)
      acceptable_grades.each do |grade|
        Grade.new(grade)
      end
    end

    it "raises an exception if an improper letter grade is given" do
      unacceptable_grades = %w(f- w k 2 -- g)
      unacceptable_grades.each do |grade|
        lambda { Grade.new(grade) }.should raise_error(ArgumentError, /is not a valid letter grade/)
      end
    end
  end

  describe "#to_s" do
    it "represents itself as the letter grade" do
      Grade.new('B+').to_s.should == "B+"
    end

    it "always represents the grade letter in upper case" do
      Grade.new('c-').to_s.should == "C-"
    end
  end

  it "does comparisons" do
    (Grade.new('B') < Grade.new('A')).should be_true
    (Grade.new('C-') > Grade.new('D')).should be_true
    (Grade.new('A-') < Grade.new('A')).should be_true
    (Grade.new('F') == Grade.new('f')).should be_true
  end

  it "sorts properly" do
    sorted_grades = [Grade.new('f'), Grade.new('c-'), Grade.new('d'), Grade.new('A-')].sort
    sorted_grades.should == [Grade.new('f'), Grade.new('d'), Grade.new('c-'), Grade.new('a-')]
  end
end
