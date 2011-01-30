require 'emergent_war'

Shoes.app(:width => 500, :height => 500) {
  fill red

  @emergent_war = EmergentWar.new(50, 50)

  @emergent_war.objects.each do |object|
    if object.class == Unit
      fill yellow if object.army_name == "army_1"
      fill blue if object.army_name == "army_2"
      object.shape = oval(object.y * 10, object.x * 10, 10)
    else
      fill black
      object.shape = rect(object.y * 10, object.x * 10, 10, 10)
    end
  end

  @animate = animate 24 do |i|
    #@animate.stop if i > 200
    @emergent_war.move_units
  end

}
