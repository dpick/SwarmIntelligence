require File.dirname(__FILE__) + "/../field"

describe "Field specs" do
  before(:each) do
    @field = Field.new
  end

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
    it "should genereate 10 field_objects with the name army" do
      @field.generate_units("army", 10, [])
      @field.field_objects.first.army_name.should == "army"
    end
  end

  describe "random_coordinates tests" do
    it "should return a set of random coordinates from the available set" do
      0.upto(49).each do |i|
        x, y = @field.get_random_coordinates
        x.should >= 0 && x.should <= 49
        y.should >= 0 && y.should <= 49
      end
    end
  end

  describe "position_available tests" do
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

  describe "visible_teammates tests" do
    it "should return [] when no units have been added" do
      @field.visible_teammates(Unit.new("team", 0, 0, 5, 100, 5)).should == []
    end

    it "should return [] if there is only 1 unit on the field" do
      @field.field_objects << Unit.new("army")
      @field.visible_teammates(Unit.new("team", 0, 0, 5, 100, 5)).should == []
    end

    it "should return [] if there are people from different armies" do
      @field.field_objects << Unit.new("army")
      @field.field_objects << Unit.new("army")
      @field.visible_teammates(Unit.new("army 2", 0, 0, 5, 100, 5)).should == []
    end

    it "should return 1 teammate" do
      @field.field_objects << Unit.new("army", 1, 1)
      @field.visible_teammates(Unit.new("army", 0, 0, 5, 100, 5)).size.should == 1
    end

    it "should return 1 teammate" do
      @field.field_objects << Unit.new("army", 1, 1)
      @field.field_objects << Unit.new("army 2", 1, 2)
      unit = Unit.new("army", 0, 0, 5, 100, 5)
      @field.visible_teammates(unit).size.should == 1
    end
  end

  describe "closest_visible_teammate tests" do
    it "should return nil if no teammates are visible" do
      @field.closest_visible_teammate([], Unit.new("army", 0, 0)).should be_nil
    end

    it "should return the closest teammate" do
      units = []
      units << Unit.new("army", 0, 0)
      units << Unit.new("army", 0, 1)
      units << Unit.new("army", 5, 4)

      @field.closest_visible_teammate(units, Unit.new("army", 3, 3)).x.should == 5
      @field.closest_visible_teammate(units, Unit.new("army", 3, 3)).y.should == 4
    end
  end

  describe "distance tests" do
    it "should return 5 for (3, 4) to (0, 0)" do
      @field.distance(0, 0, 3, 4).should == 5
    end

    it "should return 0 for (0, 0) to (0, 0)" do
      @field.distance(0, 0, 0, 0).should == 0
    end
  end
end
