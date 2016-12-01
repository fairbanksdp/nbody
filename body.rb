#require "gosu"
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
  
  def draw
    @img.draw_rot(@x, @y, 1, 0)
  end

end
