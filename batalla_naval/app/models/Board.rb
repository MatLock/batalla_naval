class Board
  require_relative 'Components.rb'
  require 'matrix'

  attr_accessor :matriz
  
  
  def initialize(rows, columns)
    @matriz = Matrix.build(rows,columns){Water.new}
  end

  def put_small_ship(coord)
    x,y = getValidCoord(coord)
  	if(!is_empty(x,y))
      return "HayBarco"
    end
    
    @matriz.send(:[]=,x,y,SmallShip.new)		
    
  end

  def put_large_ship(coord)
    large_ship = LargeShip.new
  	x,y = getValidCoord(coord)
    if(!is_empty(x,y) && !is_empty(x,y+1))
      return "HayBarco"
    end
    
    @matriz.send(:[]=,x,y,large_ship)
    @matriz.send(:[]=,x,y+1,large_ship)		
  end

  
  def is_empty(x,y)
 	  @matriz[x,y].kind_of? Water
  end

  
  def shoot(coord)
    x,y = getValidCoord(coord)
    res = @matriz[x,y].get_shoot 
    if res.eql?("SINK") || res.eql?("HIT")
      @matriz.send(:[]=,x,y,Water.new)
    end
  
    return res
  end

  def getValidCoord(coord)
    a = coord.split(":")
    x = a[0].to_i
    y= a[1].to_i
    return x,y
  end

end