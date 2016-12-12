#require 'gosu'
require './line'
require './command'
class Console < Gosu::TextInput

  attr_accessor 
  def initialize(window, screenSize, objectCommands = [[]])
    super()
    @commandList = [["help"],["get"],["set"],["exit", "qqq"],
                   ["cf"],["ls"]]
    @objectCommands = objectCommands
    @commands = []
    @desSize = screenSize
    @window = window
    @usrInput = ""
    fontOps = ["Terminal","Courier","Courier New","Consolas"]
    @font = Gosu::Font.new(@window, fontOps[3], 12)
    @lines = Array.new()
    @linesToShow = (@desSize/(3*16)).to_i
    @stdY = (@desSize-(@desSize/32))
    @deltaY = @desSize/32 
    self.text = "Type 'help' for a list of comands. Type 'exit' to close the simulation."
    newLine('out')
    self.text = ""
    newLine('in')
    @commandList.each do|command|
      newCommand(command[0], command)
    end
    @lineView = 0
  end
  
  def update
    if @usrInput != self.text
      if self.text == "" && @lines[0].txt != @usrInput
        newLine('in')
      end
      if self.text != "`"
        @usrInput = self.text
        @lines[0].update(@usrInput)
      else
        self.text = ""
      end
    end  
  end
  def draw  
    count = 1
    @lines.length > @linesToShow ? lineCount = @linesToShow : lineCount = @lines.length
    lineCount.times do|n|
      @lines[n].move(n)
      @lines[n].draw
      count+=1
    end
  end
  def lineInCount
    count = 0
    @lines.each do|line|
      if line.inOut == 'in'
        count += 1
      end
    end
    return count
  end
  def prevCommand
    @lineView += 1
    if @lineView < self.lineInCount
      self.text = self.lineChange
    else
      @lineView -= 1
    end
  end
  def followCommand
    @lineView += -1
    if @lineView > 0
      self.text = self.lineChange
    else
      @lineView += 1
      self.text = "" 
    end
  end
  def lineChange
    count = 0
    @lines.each do|line|
      if line.inOut == 'in'
        if count == @lineView
          return line.txt
	else
	  count+=1
	end
      end
    end
  end  
  def respond
    if self.text != "" 
      @inputArr = @usrInput.split
      @commands.each do|command|
        if command.check(@inputArr[0])
	  break
	end
      end
      newLine('out')
      self.text = ""
    else
      newLine('in')
    end
    @lineView = 0
  end
  def newLine(inOut)
    @lines.unshift(CommandLine.new(@font,@deltaY,@stdY,self.text,inOut,@window.fileName))
  end
  def newCommand(command, trigger)
    @commands.push(Command.new(self, command, trigger, command))
  end

  def help
    self.text = @commandList + @objectCommands
  end
  def exit
    $exit = 1 # Window does not get reopened
    @window.close
  end
  def cf
    if @inputArr[1] != nil
      @window.fileName = @inputArr[1]
    else
      @window.fileName = "planets.txt"
    end
    @window.setUp
    self.text = "Simulation changed to #{@window.fileName}"
  end
  def ls
    count = 1 
    @window.bodies.each do|n|
      self.text = "body: #{n}, ID: #{n.id}, #{n.name}"
      if count < @window.bodies.length
        newLine('out')
      end
      count+=1
    end
  end
  def set
    if @inputArr[1] == nil
      self.text = "Error. Command requires at least 1 paramater."
    else
      case @inputArr[2] 
      when "to"
        case @inputArr[1] # Var to be set
        when "screenSize"
	  $ScreenSize = @inputArr[3].to_i
	  self.text = "Screen dimentions set to #{$ScreenSize} by #{$ScreenSize}"
          @window.close
        when "timeScale"
          @window.time = @inputArr[3].to_i 
          self.text = "Time scale set to #{@window.time}"
        else
          self.text = "#{@inputArr[1]}: Value either cannot be changed, or does not exist."
        end
      else
        body = @inputArr[1].split(".")
        case body[0]
        when "bodies"
	  if @window.bodies[@inputArr[2].to_i].instance_variable_defined?("@#{body[1]}")
	    @window.bodies[@inputArr[2].to_i].instance_variable_set("@#{body[1]}", @inputArr[3])
	    @window.bodies[@inputArr[2].to_i].send("set_#{body[1]}")
	    self.text = "#{body[1]} set to #{@inputArr[3]}"
	  else
	    self.text = "#{body[1]}: Value either cannot be set, or does not exist."
	  end
        else
          self.text = "Missing keyword 'to'."
        end
      end # End Set command
    end 
  end

  
  def get
    case @inputArr[1] # Var to be set
    when "screenSize"
      self.text = "Screen dimentions are set to #{$ScreenSize} by #{$ScreenSize}."
    when "timeScale"
      self.text = "Time scale is set to #{@window.time}."
    when nil
      self.text = "Error. Command requires at least 1 paramater."
    else
      body = @inputArr[1].split(".")
      case body[0]
      when "bodies"
	if @window.bodies[@inputArr[2].to_i].instance_variable_defined?("@#{body[1]}")
	  self.text = "#{body[1]} is #{@window.bodies[@inputArr[2].to_i].instance_variable_get("@#{body[1]}")}"
	else
	  self.text = "#{body[1]}: Value either is not defined, or does not exist."
	end
      when "window"
	if @window.instance_variable_defined?("@#{body[1]}")
	  self.text = "#{body[1]} is #{@window.instance_variable_get("@#{body[1]}")}"
	else
	  self.text = "#{body[1]}: Value either is not defined, or does not exist."
	end
      else
        self.text = "#{@inputArr[1]}: Value either is not defined, or does not exist."
      end
    end
  end  
  

end

