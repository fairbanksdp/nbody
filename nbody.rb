require "gosu"
require_relative "z_order"
require "./body"
require "./vector"
require "./console"
G = 6.67408e-11 #Gravitational Constant
_f = ARGV #Initial arguments
if _f[0] == nil || _f[0] == "nil"
  _f[0] = "planets.txt" 
end
if _f[1] == nil || _f[1] == "nil"
  _f[1] = 640
end
$ScreenSize = _f[1].to_i
if _f[2] == nil || _f[2] == "nil"
  _f[2] = 1
end
#TimeScale = (_f[2].to_f)*1000000/numOfBodies
$TimeScale = (_f[2].to_f)*25000

class NbodySimulation < Gosu::Window
  attr_accessor :fileName, :time, :bodies
  def initialize(_f)
    super($ScreenSize, $ScreenSize, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    @fileName = _f
    @time = $TimeScale
    @screenSize = $ScreenSize
    @console = Console.new(self, $ScreenSize)
    @consoleState = false
    self.setUp
  end
  def setUp
    fileSetUp(@fileName)
    @uniScale = @uniSize/@screenSize
    id = -1
    @bodies = @universeInfo.each.map do|infoStr|
      bodyInfo = infoStr.split
      bI = 5.times.map {|n|bodyInfo[n].to_f}
      id += 1
      Body.new(bI[0], bI[1], bI[2], bI[3], bI[4], bodyInfo[5], id)
    end
  end
  def physics(body1,body2)
    if !(body1.pos_x == body2.pos_x && body1.pos_y == body2.pos_y)
      posDif = Vect.new(body1.pos_x,body1.pos_y,body2.pos_x,body2.pos_y)
      force = ((body1.mass)*(body2.mass)*G)/(posDif.mag**2)
      body1.update(force*posDif.unitVect[0], force*posDif.unitVect[1])
    end
  end
  def update
    if !@consoleState
      @bodies.each do|body1|
        @bodies.each do|body2|
	    physics(body1,body2)
        end
      end
    else
      @console.update
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    
    threads = @bodies.each.map do|body|
      Thread.new do
        if !@consoleState
          body.move(@time)
	end
        body.draw(@uniScale, @screenSize)
	Thread.current.exit
      end
    end
    threads.each {|n|n.join}
    if @consoleState
      @console.draw
    end
  end

  def button_down(id)
    if id == Gosu::KbEscape
      $exit = 1
      close
    elsif id == char_to_button_id('`')
      if @consoleState
        @consoleState = false
	self.text_input = nil
      else
	self.text_input = @console
        @consoleState = true
      end
    elsif id == Gosu::KbReturn
      if @consoleState
        @console.respond
      end
    elsif id == Gosu::KbUp
      if @consoleState
        @console.prevCommand
      end
    elsif id == Gosu::KbDown
      if @consoleState
        @console.followCommand
      end
    end

  end

  def fileSetUp(_f)
    f = File.open("simulations/#{_f}", "r")
    numOfBodies = f.first.to_i
    count = 0
    universeInfo = f.each_line.map do|line|
      if line != "\n" && numOfBodies >= count
        count+=1
        line
      end

    end
    f.close
    universeInfo.compact!
    @uniSize = universeInfo.shift.to_f
    @universeInfo = universeInfo
  end
end
$exit = 0
while $exit == 0
window = NbodySimulation.new(_f[0])
window.show
end
