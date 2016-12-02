require "gosu"
require_relative "z_order"
require "./body"
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
      bI = infoStr.split
      Body.new(bI[0], bI[1], bI[2], bI[3], bI[4], bI[5])
    end
  end

  def physics
    @bodies.each do|body|
      

    end
  end
  def radius(x1,y1,x2,y2)

  end
  def update
    
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @bodies.each do|body|
      body.draw(@uniScale)
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
window = NbodySimulation.new(n, s, universeInfo)
window.show

