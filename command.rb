class Command

  def initialize(console, name, trigger, method)
    @console = console
    @name = name
    @trigger = trigger
    @method = method
  end
  def check(input)
    if @trigger.include?(input) && @console.respond_to?(@method)
      @console.send(@method)
      return true
    else
      @console.text = "#{input}: Command not found."
      return false
    end
  end
  def addTrigger(trigger)
    @trigger.push(trigger)
  end
end
      
      
