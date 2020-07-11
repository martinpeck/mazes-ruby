require_relative 'cell'

class HexCell < Cell
  attr_accessor :northeast, :northwest
  attr_accessor :southeast, :southwest
  
  def neighbours
    list = []
    list << northwest if northwest
    list << north if north
    list << northeast if northeast
    list << southwest if southwest
    list << south if south
    list << southeast if southeast
    list
  end
end
