require "gosu"
require_relative "z_order"
require "./body"
require "./vector"
G = 6.67408e-11
_f = ARGV 
if _f[0] == nil
  _f[0] = "planets.txt" 
end
f = File.open("simulations/#{_f[0]}", "r")
universeInfo = f.each_line.map {|line|line}
f.close

class NbodySimulation < Gosu::Window

  def initialize(numOfBodies, uniSize, bodies = [])
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    @uniScale = uniSize/640
    @bodies = bodies.each.map do|infoStr|
      bodyInfo = infoStr.split
      bI = 5.times.map {|n|bodyInfo[n-1].to_f}
      Body.new(bI[0], bI[1], bI[2], bI[3], bI[4], bodyInfo[5])
    end
  end

  def physics(body1)
    @bodies.each do|body2|
      if body1.x != body2.x || body1.y != body2.y
        posDif = Vect.new(body1.x,body1.y,body2.x,body2.y)
        posDif.update(body1.x,body1.y,body2.x,body2.y)
	force = ((body1.mass)*(body2.mass)*G)/(posDif.mag**2)
	#body1.update(force*Math.cos(posDif.rad), force*Math.sin(posDif.rad))
	body1.update(force*posDif.unitVect[0], force*posDif.unitVect[1])
      end
    end
  end
  def radius(x1,y1,x2,y2)

  end
  def update
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    #update()
    @bodies.each do|body1|
      physics(body1)
      body1.move
    end
    @bodies.each do|body1|
      #body1.move
    end
    @bodies.each do|body|
      body.draw(@uniScale)
    end
    print "test"
    $stdout.flush
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
  
end
n = universeInfo.shift.to_i
s = universeInfo.shift.to_f
window = NbodySimulation.new(n, s, universeInfo)
#window.physics
window.show

