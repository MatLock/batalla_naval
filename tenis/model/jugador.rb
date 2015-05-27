class Jugador
	attr_accessor :nombre,:puntos, :partido, :ventaja

	def initialize(nombre,partido)
		@nombre = nombre
		@puntos = 0
		@ventaja = false
		@partido = partido
	end

	def anotar()
		if(@puntos == 45 && partido.puntosJugadorEnemigo(@nombre) == 45)
			aplicarReglaVentaja()
			return
		end
		
		if(@puntos == 45 && (ventaja || partido.puntosJugadorEnemigo(@nombre) < 45))
			partido.anotarSet(@nombre)
			@puntos=0
			return
		end

		if (@puntos < 45)
			@puntos = @puntos + 15		
		end
	end

	def quitarVentaja()
		@ventaja = false
	end

	def aplicarReglaVentaja()
		if not partido.ventajaJugadorEnemigo(@nombre) 			
			@ventaja = true
		else
			partido.quitarVentajaJugadorEnemigo(@nombre)
		end		
	end

	def reset()
		@puntos = 0
		@ventaja = false
	end

end
