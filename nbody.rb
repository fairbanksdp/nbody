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
#      bodyInfo.each {|n|print "#{n}\n"}
      bI = 5.times.map {|n|bodyInfo[n].to_f}
      Body.new(bI[0], bI[1], bI[2], bI[3], bI[4], bodyInfo[5])
    end
    @time = 1000000/numOfBodies
  end

  def physics(body1)
    @bodies.each do|body2|
#      print "body1(#{body1.pos_x}, #{body1.pos_y}) "
#      print "body2(#{body2.pos_x}, #{body2.pos_y})\n"
      if !(body1.pos_x == body2.pos_x && body1.pos_y == body2.pos_y)
#        print "!!!TRIGGERED!!!"
        posDif = Vect.new(body1.pos_x,body1.pos_y,body2.pos_x,body2.pos_y)
        #posDif.update(body1.x,body1.y,body2.x,body2.y)
#	print "radi: #{posDif.mag}; \n"
#	print "m1: #{body1.mass}; \n"
#	print "m2: #{body2.mass}; \n"
	force = ((body1.mass)*(body2.mass)*G)/(posDif.mag**2)
#	print "force: #{force}; \n"
	body1.update(force*posDif.unitVect[0], force*posDif.unitVect[1])
      end
#      print "\n\n"
    end
  end
  def update
#      if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
    @bodies.each do|body1|
      physics(body1)
    end
#    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @bodies.each do|body|
      body.draw(@uniScale)
      body.move(@time)
    end
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
  
end
n = universeInfo.shift.to_i
s = universeInfo.shift.to_f
#print "#{universeInfo.pop}"
window = NbodySimulation.new(n, s, universeInfo)
#window.physics
window.show

