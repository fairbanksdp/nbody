require "./vector"
class Body

  attr_accessor :x, :y, :vel_x, :vel_y, :mass
  def initialize(xI, yI, velXI, velYI, mass, img)
    @x = xI
    @y = yI
    @vel_x = velXI 
    @vel_y = velYI 
    @mass = mass
    @img = Gosu::Image.new("images/#{img}")
  end

  def move
    @x += @vel_x
    @y += @vel_y
  end
  
  def update
    #ve
  end
  def draw(drawScale)
    dx = (@x/(drawScale*2))+320
    dy = (@y/(drawScale*2))+320
    @img.draw_rot(dx, dy, 1, 0)
  end

end
