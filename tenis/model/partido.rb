class Partido
	
	attr_accessor :jugador1,:jugador2, :sets, :games, :ganador

	def initialize()
		@sets = Hash.new
		@games = Hash.new
		@jugador1
		@jugador2
		@ganador
	end
	
	def iniciar(jugador1,jugador2)
		@sets[jugador1.nombre] = 0	
		@sets[jugador2.nombre] = 0	
		@games[jugador1.nombre] = 0	
		@games[jugador2.nombre] = 0	
		@jugador1 = jugador1
		@jugador2 = jugador2
	end

	def anotarSet(nombre)
			if(@sets[nombre] == 6)
				aplicarReglaDeGame(nombre)			
				return
			end		
		@sets[nombre] = @sets[nombre] + 1		
	end

	def puntosJugadorEnemigo(nombre)
		if(nombre == @jugador1.nombre)
			return @jugador2.puntos		
		end
		return @jugador1.puntos
	end

	def ventajaJugadorEnemigo(nombre)
		if (nombre == @jugador1.nombre)
			return @jugador2.ventaja
		end
		return @jugador1.ventaja
	end

	def quitarVentajaJugadorEnemigo(nombre)
		if (nombre == @jugador1.nombre)
			@jugador2.quitarVentaja()
		else
			@jugador1.quitarVentaja()
		end 
	end

	def aplicarReglaDeGame(nombre)
			@games[nombre] = @games[nombre] + 1
			if(@games[nombre] == 2)
				@ganador = nombre
			end
		resetearPuntosySets()
	end

	def resetearPuntosySets()
		@jugador1.reset()
		@jugador2.reset()
		@sets[@jugador1.nombre] = 0
		@sets[@jugador2.nombre] = 0
	end

end
