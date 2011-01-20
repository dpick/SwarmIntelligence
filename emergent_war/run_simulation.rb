require 'emergent_war'

Shoes.app {
  fill red

  @emergent_war = EmergentWar.new(50, 50)

  @emergent_war.objects.each do |object|
    if object.class == Unit
      fill red
      object.shape = oval(object.x * 10, object.y * 10, 10)
    else
      fill black
      object.shape = rect(object.x * 10, object.y * 10, 10, 10)
    end
  end

  @animate = animate 24 do |i|
    @animate.stop if i > 30
    @emergent_war.move_units
  end

}
