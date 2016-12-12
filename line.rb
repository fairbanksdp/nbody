require './z_order'
class CommandLine
  attr_accessor :txt, :inOut 
  def initialize(font, dy, std_y, txt, inOut='out',fileName)
    @x = 10
    @fileName = fileName
    @std_y = std_y
    @y = std_y
    @dy = dy
    @font = font
    @txt = txt
    @inOut = inOut
    @showing = true
  end
  def move(pos)
    @y = @std_y-(pos*@dy)
  end
  def update(txt)
    @txt = txt
  end
  def draw
    if @inOut == 'out'
      @font.draw(@txt,@x,@y,ZOrder::UI,1.0,1.0,0xff_ffffff)
    else
      @font.draw("#{@fileName}> #{@txt}",@x,@y,ZOrder::UI,1.0,1.0,0xff_ffffff)
    end
  end

  def hide
    @showing = false
  end
  def show
    @showing = true
  end
end
