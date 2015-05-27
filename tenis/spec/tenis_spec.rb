require 'rspec'
require_relative '../model/jugador.rb'
require_relative '../model/partido.rb'



describe 'Tenis' do
	
	before (:each) do
		@partido = Partido.new()
		@jugador1 = Jugador.new('Pepa',@partido)			
		@jugador2 = Jugador.new('Pepe',@partido)
		@partido.iniciar(@jugador1,@jugador2)
	end

		it 'Al comenzar el jugador deberia iniciar con 0 puntos' do
			@jugador1.puntos.should be 0
		end

		it ' Al anotar un punto y tener 0 puntos, su puntaje nuevo debe ser 15' do	
			@jugador1.anotar()
			@jugador1.puntos.should eq 15
		end

		it 'Al anotar un punto y tener 15 puntos, su puntaje nuevo debe ser 30' do
			@jugador1.puntos = 15
			@jugador1.anotar()
			@jugador1.puntos.should eq 30
		end

		it 'Al anotar un punto y tener 30 puntos, su puntaje nuevo debe ser 45' do	
            @jugador1.puntos = 30
			@jugador1.anotar()
			@jugador1.puntos.should eq 45
		end

		it 'Al anotar un punto y tener 45 puntos en caso de que el jugador enemigo tenga 45 puntos tambien se le 
			dará una ventaja al jugador que anoto el punto' do
			@jugador1.puntos = 45
            @jugador2.puntos = 45
			@jugador1.anotar()
            @jugador1.ventaja.should eq true			
			@jugador1.puntos.should eq 45
		end

			it 'Al anotar un punto y tener 45 puntos en caso de que el jugador enemigo tenga 45 puntos y tenga ventaja, al jugador
				enemigo se le quitara la ventaja' do			
			@jugador1.puntos = 45
            @jugador2.puntos = 45
			@jugador2.ventaja = true
			@jugador1.anotar()
            @jugador2.ventaja.should eq false			
			@jugador1.puntos.should eq 45
			@jugador2.puntos.should eq 45
		end

		it 'Al anotar un punto y tener 45 puntos, y el jugador enemigo no tiene ventaja, se ganara el set' do
			@jugador1.puntos = 45
			@jugador1.anotar()
			@jugador1.puntos.should eq 0
			@jugador1.ventaja.should be false
			@partido.sets[@jugador1.nombre].should eq 1			
		end

		it 'Al anotar un punto teniendo 45 puntos del sexto set se gana un game' do
			@jugador1.puntos = 45
			@partido.sets[@jugador1.nombre]=6
			@jugador1.anotar()
			@partido.sets[@jugador1.nombre].should eq  0
			@partido.games[@jugador1.nombre].should eq  1
			@jugador1.puntos.should eq 0
		end

		it 'este test describe el escenario en el que un jugador gana el juego' do
			@jugador1.puntos = 45
			@partido.sets[@jugador1.nombre] = 6
			@partido.games[@jugador1.nombre] = 1
			@jugador1.anotar()
			@partido.ganador.should be @jugador1.nombre
		end
		
end
