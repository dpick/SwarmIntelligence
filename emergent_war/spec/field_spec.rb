require File.dirname(__FILE__) + "/../field"

describe "Field specs" do
  describe "initialization test" do
    it "should create a default field" do
      field = Field.new
      field.height.should == 50
      field.width.should == 50
      field.units.should == []
    end

    it "should create a field with a different height and width" do
      field = Field.new(height = 20, width = 30)
      field.height.should == 20
      field.width.should == 30
      field.units.should == []
    end
  end

  describe "unit generation tests" do
    before(:each) do
      @field = Field.new
    end

    it "should genereate 10 units with the name army" do
      @field.generate_units("army", 10)
      @field.units.size.should == 10
      @field.units.first.army_name.should == "army"
    end
  end
end
