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

  def move(time)
    accelX = @forceX/@mass
    accelY = @forceY/@mass
    @vel_x += accelX*time#/2
    @vel_y += accelY*time#/2
    @x += @vel_x*time #+ (accelX/2)*(time**2)
    @y += @vel_y*time #+ (accelY/2)*(time**2)
    @forceX = 0
    @forceY = 0
  end
  
  def update(forceX, forceY)
    @forceX += forceX
    @forceY += forceY
  end
  def draw(drawScale)
    #print "#{drawScale}\n"
    dx = (@x/(drawScale*2))+(ScreenSize/2)
    dy = (@y/(drawScale*2))+(ScreenSize/2)
    #print "dx: #{dx} dy: #{dy}\n"
    @img.draw_rot(dx, dy, 1, 0)
  end

  def pos_x
    @x
  end
  def pos_y
    @y
  end
end
