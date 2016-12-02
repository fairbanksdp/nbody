require "Matrix"
Pi = Math::PI
class Vect

  attr_accessor :x, :y, :rad, :mag, :unitVect
  def initialize(x1,y1,x2,y2)  
    update(x1,y1,x2,y2)
  end
  
  def update(x1,y1,x2,y2)
    @x = x2 - x1
    @y = y2 - y1
    @vect = Vector[@x,@y]
    @unitVect = @vect.normalize
    uX = @unitVect[0]
    uY = @unitVect[1]
    @mag = @vect.r
    if uY >= 0
      @rad = @vect.angle_with(Vector[1,0])
    elsif uY < 0
      rad = @vect.angle_with(Vector[1,0])
      @rad = Pi + rad
    end
  end


end

