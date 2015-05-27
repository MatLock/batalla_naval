require_relative '../spec_helper.rb'
require_relative '../../app/models/Tablero.rb'
require_relative '../../app/models/Barco.rb'
require_relative '../../app/models/Exceptions.rb'
require_relative '../../app/models/BarcoYaExistenteException.rb'



describe 'Tablero'  do 
	
	before (:each) do
		@tablero = Tablero.new(5,5)
	end

	it 'Al iniciar el juego' do
		expect(@tablero).to be #
	end

	it 'Al agregar un barco chico en la posicion (x,y), la misma ya no debe estar ocupada' do
		@tablero.ponerBarcoEn("(3:3)",BarcoChico.new("Foxtrox"))
		expect(@tablero.mapa[3][3].nombre).to eq "Foxtrox"
	end

	it 'Al agregar un barco fuera de los limites del tablero se debe esperar una excepcion' do
		expect { @tablero.ponerBarcoEn("(6:6)", BarcoChico.new("Alpha"))
		}.to raise_error(FueraDelTableroException)
	end

	it 'Al agregar un barco en una coordenada donde ya existe otro barco se debe esperar una excepcion' do
		@tablero.ponerBarcoEn("(3:3)", BarcoChico.new("Alpha"))
		expect { @tablero.ponerBarcoEn("(3:3)", BarcoChico.new("Alpha"))
		}.to raise_error(BarcoYaExistenteException)
	end


	it "Al agregar un barco grande en las posiciones (x,y),(z,t), las mismas ya no deben estar vacias en el tablero" do
		@tablero.ponerBarcoEn("(2:2),(3:3),(4:4)", BarcoLargo.new("Delta",3))
		expect(@tablero.mapa[2][2].nombre).to eq "Delta"
		expect(@tablero.mapa[3][3].nombre).to eq "Delta"
		expect(@tablero.mapa[4][4].nombre).to eq "Delta"
	end	

end


describe 'Disparo' do
		before (:each) do
			@tablero2 = Tablero.new(5,5)
			@tablero2.ponerBarcoEn("(4:1),(4:2)",BarcoLargo.new("Charlie",2))
		end

		it "Al disparar a una coordenada y fallar, debo obtener 'water'" do
			expect(@tablero2.dispararEn("(3:3)")).to eq "water"
		end

		it "Al disparar a una coordenada y que haya un barco en esa posicion debo obtener 'hit'" do
			expect(@tablero2.dispararEn("(4:1)")).to eq "hit"
		end

		it "Al hundir un barco debo obtener 'sink', una vez hundido en la misma coordenada debo obtener 'water' si se vuelve a disparar" do
			@tablero2.dispararEn("(4:1)")
			expect(@tablero2.dispararEn("(4:2)")).to eq "sink"
			expect(@tablero2.dispararEn("(4:1)")).to eq "water"
		end
end