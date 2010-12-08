require 'ant'
require 'city'

describe Ant, "Ant Specs" do
  before(:each) do
    @city = City.new(1, [], 0, 0)
    @cities = [@city]
    @ant = Ant.new(@cities)
  end

  it "should initialize with a city list" do
    @ant.cities.should == @cities
  end

  it "should remove a visited city" do
    @ant.visit(@city)
    @ant.cities.include?(@city).should be_false
  end

  it "should return false if a city has not been visited yet" do
    @ant.visited?(@city).should be_false
  end

  it "should return true if a city has been visited" do
    @ant.visit(@city)
    @ant.visited?(@city).should be_true
  end
end
