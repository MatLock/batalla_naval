class Barco

	attr_accessor :nombre


	def recibirDisparo
	end

	def to_s
		return @nombre
	end

	def hayBarco()
		return true
	end

	def initialize(nombre)
		@nombre = nombre
	end
end

class BarcoChico < Barco
	
	def initialize(nombre)
		super(nombre)
	end

	def recibirDisparo()
		return "hit"
	end
end

class SinBarco < Barco

	def recibirDisparo()
		return "water"
	end

	def initialize()
	end

	def hayBarco()
		return false
	end

	def to_s
		return "water"
	end

end


class BarcoLargo < Barco
	attr_accessor :longitud

	def initialize(nombre,longitud)
		super(nombre)
		@longitud = longitud
	end

	def recibirDisparo()
		@longitud = @longitud -1
		if (@longitud == 0)
			return "sink"
		end
		return "hit"
	end

end
