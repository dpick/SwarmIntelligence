require File.dirname(__FILE__) + "/../unit"

describe "unit specs" do
  describe "initialization tests" do
    it "should create a unit with defaults" do
      unit = Unit.new("army")
      unit.army_name.should == "army"
      unit.damage.should == 5
      unit.health.should == 100
      unit.vision.should == 5
      unit.x.should == 0
      unit.y.should == 0
    end

    it "should create a unit with non-default values" do
      unit = Unit.new("army", 5, 5, 10, 10, 10)
      unit.army_name.should == "army"
      unit.damage.should == 10
      unit.health.should == 10
      unit.vision.should == 10
      unit.x.should == 5
      unit.y.should == 5
    end
  end

  describe "health tests" do
    before(:each) do
      @unit = Unit.new("army")
    end

    it "should take damage" do
      @unit.health.should == 100
      @unit.take_hit(20)
      @unit.health.should == 80
    end

    it "should set health to 0 if damage is creater than health" do
      @unit.take_hit(105)
      @unit.health.should == 0
    end
  end
end
