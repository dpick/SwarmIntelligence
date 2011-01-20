require 'emergent_war'

Shoes.app {
  stroke rgb(0.5, 0.5, 0.7)
  fill red

  @emergent_war = EmergentWar.new(50, 50)

  blocks = []

  #0.upto(50).each do |x|
  #  0.upto(50).each do |y|
  #    blocks << rect(x * 10, y * 10, 10, 10)
  #  end
  #end

  @emergent_war.objects.each do |object|
    if object.class == Unit
      fill red
      oval(object.x * 10, object.y * 10, 10)
    else
      fill black
      rect(object.x * 10, object.y * 10, 10, 10)
    end
  end

  #animate 200 do |i|
  #  blocks.first.move(i, i)
  #end

  #5.upto(45).each do |x|
  #  line(x * 10, 50, x * 10, 450)
  #end

  #5.upto(45).each do |y|
  #  line(50, y * 10, 450, y * 10)
  #end

}
