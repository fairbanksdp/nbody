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

  def physics
    vectors = []
    count1 = 0
    count2 = 0
    @bodies.each do|body1|
      @bodies.each do|body2|
        if count1 != count2
          vectors.push(Vect.new(body1.x,body1.y,body2.x,body2.y))
	else
	end
        count2++
      end
      count2 = 0
      count1++
    end
    puts "#{vectors}"
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
window.physics
window.show

