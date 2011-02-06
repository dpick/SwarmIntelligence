require 'emergent_war'
require 'pp'

Shoes.app(:width => 700, :height => 700) {
  fill red

  @emergent_war = EmergentWar.new(70, 70)

  @emergent_war.objects.each do |object|
    if object.class == Unit
      fill yellow if object.army_name == "david"
      fill blue if object.army_name == "mark"
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
