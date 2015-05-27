require_relative '../../app/models/Board.rb'
require_relative '../spec_helper.rb'
require 'matrix'

describe 'Battleship' do

  before (:each) do
    @board = Board.new 5,5
  end

  it 'create a Board' do
    expect(@board.kind_of? Board).to eq true
  end

  it 'should create a 5x5 Board' do
    @board.matriz.row_count.should be 5
    @board.matriz.column_count.should be 5
  end

  it 'should create small ship in 3:3 location' do
    @board.put_small_ship "3:3"
    expect(@board.matriz[3,3].nombre).to eq "SmallShip"
  end

  it 'should create large ship in 3:3 location' do
    @board.put_large_ship "3:3"
    expect(@board.matriz[3,3].nombre).to eq "LargeShip"
    expect(@board.matriz[3,4].nombre).to eq "LargeShip"
  end

  it 'should get HayBarco if i create small ship in location 3:3' do
    @board.put_small_ship "3:3"
    @res = @board.put_small_ship "3:3"
    expect(@res).to eq "HayBarco"
  end

  it 'should get HayBarco if i create large ship in location 3:3' do
    @board.put_large_ship "3:3"
    @res = @board.put_large_ship "3:4"
    expect(@res).to eq "HayBarco"
  end




end

describe 'Shoot' do

    before (:each) do
      @board = Board.new 5,5
    end

  it 'should get HIT when I shoot LargeShip' do
    @board.put_large_ship "3:3"
    expect(@board.shoot("3:3")).to eq 'HIT'
  end

  it 'should be one part of LargeShip when I hit it' do
    @board.put_large_ship "3:3"
    @board.shoot("3:3")
    expect(@board.matriz[3,4].parts).to eq 1
  end  

  it 'should get WATER when I shoot LargeShip' do
    expect(@board.shoot("3:3")).to eq 'WATER'
  end 

  it 'should get SINK when I shoot twice a LargeShip ' do
    @board.put_large_ship "3:3"
    expect(@board.shoot("3:3")).to eq 'HIT'
    expect(@board.shoot("3:4")).to eq 'SINK'
  end
end