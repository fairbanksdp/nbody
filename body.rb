require "./vector"
class Body

  attr_accessor :x, :y, :vel_x, :vel_y, :mass, :forceX, :forceY, :name, :id, :img
  def initialize(xI, yI, velXI, velYI, mass, img, id)
    @name = img.slice(0, (img.length-4))
    @x = xI
    @y = yI
    @vel_x = velXI 
    @vel_y = velYI 
    @mass = mass
    @forceX = 0
    @forceY = 0
    @img = Gosu::Image.new("images/#{img}")
    @id = id
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
  def draw(drawScale, screenSize)
    dx = (@x/(drawScale*2))+(screenSize/2)
    dy = (@y/(drawScale*2))+(screenSize/2)
    @img.draw_rot(dx, dy, 1, 0)
  end

  def pos_x
    @x
  end
  def pos_y
    @y
  end
  def set_x
    @x = @x.to_f
  end
  def set_y
    @y = @y.to_f
  end
  def set_vel_x
    @vel_x = @vel_x.to_f
  end
  def set_vel_y
    @vel_y = @vel_y.to_f
  end
  def set_mass
    @mass = @mass.to_f
  end
  def set_forceX
    @forceX = @forceX.to_f
  end
  def set_forceY
    @forceY = @forceY.to_f
  end

end
