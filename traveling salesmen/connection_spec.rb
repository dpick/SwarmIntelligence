require 'connection'
require 'city'

describe Connection, "when first created" do
  before(:each) do
    @city_a = City.new(1, [], 5, 5)
    @city_b = City.new(2, [], 1, 2)
    @connection = Connection.new(@city_a, @city_b, 5)
  end

  it "should set the phermone level to 0 on creation" do
    @connection.phermone_level.should == 0
  end

  it "should update the phermone level by 5" do
    @connection.update_phermone_level(5)
    @connection.phermone_level.should == 5
    @connection.update_phermone_level(5)
    @connection.phermone_level.should == 10
  end

  it "should calculate distance properly" do
    @connection.distance.should == 5 
  end

  it "visibility should be 1 / distance" do
    @connection.visibility.should == 1 / 5
  end

  it "should contain city_a" do
    @connection.contains?(@city_a).should == true
  end

  it "should contain city_b" do
    @connection.contains?(@city_b).should == true
  end

  it "should not contain city_c" do
    city_c = City.new(3, [], 5, 5)

    @connection.contains?(city_c).should == false
  end
end
