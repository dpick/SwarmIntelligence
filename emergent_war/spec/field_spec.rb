require File.dirname(__FILE__) + "/../field"

describe "Field specs" do
  describe "initialization test" do
    it "should create a default field" do
      field = Field.new
      field.height.should == 50
      field.width.should == 50
      field.field_objects.should == []
    end

    it "should create a field with a different height and width" do
      field = Field.new(height = 20, width = 30)
      field.height.should == 20
      field.width.should == 30
      field.field_objects.should == []
    end
  end

  describe "unit generation tests" do
    before(:each) do
      @field = Field.new
    end

    it "should genereate 10.field_objects with the name army" do
      @field.generate_units("army", 10)
      @field.field_objects.first.army_name.should == "army"
    end
  end

  describe "random_coordinates tests" do
    before(:each) do
      @field = Field.new
    end

    it "should return a set of random coordinates from the available set" do
      0.upto(49).each do |i|
        x, y = @field.get_random_coordinates
        x.should >= 0 && x.should <= 49
        y.should >= 0 && y.should <= 49
      end

      @field.available_coordinates[:x].should be_empty
      @field.available_coordinates[:y].should be_empty
    end
  end

  describe "position_available tests" do
    before(:each) do
      @field = Field.new
    end

    it "should return true if a position is open" do
      @field.position_available(0, 0).should be_true
    end

    it "should return false if a position is taken" do
      @field.field_objects << Wall.new(4, 4, [])
      @field.field_objects << Wall.new(8, 4, [])
      @field.field_objects << Wall.new(20, 4, [])
      @field.field_objects << Wall.new(4, 9, [])
      @field.position_available(4, 4).should be_false
      @field.position_available(8, 4).should be_false
      @field.position_available(20, 4).should be_false
      @field.position_available(4, 9).should be_false
    end

    it "should return false if x is less than 0" do
      @field.position_available(-1, 5).should be_false
    end

    it "should return false if y is less than 0" do
      @field.position_available(5, -1).should be_false
    end

    it "should return false if x is greater than height" do
      @field.position_available(55, 5).should be_false
    end

    it "should return false if y is greater than width" do
      @field.position_available(55, -1).should be_false
    end
  end
end
