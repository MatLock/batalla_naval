class Components
	def get_shoot
  	end
end

class Water < Components
	def get_shoot
		'WATER'
	end
end

class Ship < Components
 
	attr_accessor :nombre

	def initialize(nombre)
	    @nombre = nombre 
	end

end


class SmallShip < Ship
 	
 	def initialize
	   super("SmallShip") 
	end

	def get_shoot
		"SINK"
	end

end


class LargeShip < Ship

	attr_accessor :parts
 
	def initialize
	   super("LargeShip")
	   @parts = 2
	end

	def get_shoot
		@parts = @parts - 1 
		if(@parts == 0)
			return "SINK"
		end
		"HIT"
	end

end
