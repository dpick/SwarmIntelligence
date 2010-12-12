require 'city'

describe City, "when first created" do
  before(:each) do
    @city = City.new(1, [], 20, 10)
    @city_b = City.new(2, [], 5, 5)
  end

  it "should set the id and coordinates" do
    @city.id.should == 1
  end

  it "should add a neighbor" do
    @city.add_neighbor(@city_b)
    @city.neighbors.length.should == 1
  end

  it "should be connected to city_b" do
    @city.add_neighbor(@city_b)

    @city.connected_to?(@city_b).should be_true
  end

  it "should not be connected to itself" do
    @city.connected_to?(@city).should be_false
  end

  it "should not be connected to city_c" do
    city_c = City.new(3, [], 4, 10)

    @city.connected_to?(city_c).should be_false
  end
end
