require "./vector"
class Body

  attr_accessor :x, :y, :vel_x, :vel_y, :mass, :forceX, :forceY
  def initialize(xI, yI, velXI, velYI, mass, img)
    @x = xI
    @y = yI
    @vel_x = velXI 
    @vel_y = velYI 
    @mass = mass
    @forceX = 0
    @forceY = 0
    @img = Gosu::Image.new("images/#{img}")
  end

  def move
    @vel_x += @forceX/@mass
    @vel_y += @forceY/@mass
    @x += @vel_x
    @y += @vel_y
  end
  
  def update(forceX, forceY)
    @forceX += forceX
    @forceY += forceY
  end
  def draw(drawScale)
    dx = (@x/(drawScale*2))+320
    dy = (@y/(drawScale*2))+320
    @img.draw_rot(dx, dy, 1, 0)
  end

end
