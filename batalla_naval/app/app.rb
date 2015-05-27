require_relative 'models/Board'
require 'matrix'

module Battleship
  class App < Padrino::Application
    register Padrino::Rendering
    register Padrino::Helpers

    enable :sessions

    def crearTabla(cx, cy, accion, result)
      @tabla = '<table class="tablero" name="tablero"><tbody>'
      for y in 1..session[:alto].to_i
          @tabla += '<tr>'
          for x in 1..session[:ancho].to_i
            if accion.eql?""
              @tabla += '<td style="background-color:blue"></td>'
            elsif accion.eql?"disparar"
              
                @qhay = session[:Disparos][x,y]

                if cx== x && cy==y
                  case result
                  when "WATER"
                    session[:Disparos].send(:[]=,x,y, 'agua')
                    @tabla += '<td class="agua"></td>' 
                  when "HIT"
                    session[:Disparos].send(:[]=,x,y, 'hit')
                    @tabla += '<td class="hit"></td>'
                   when "SINK"
                     session[:Disparos].send(:[]=,x,y, 'sink')
                    @tabla += '<td class="sink"></td>'
                  end
                else
                  case @qhay
                  when "agua"
                    @tabla += '<td class="agua"></td>'
                  when "hit"
                    @tabla += '<td class="hit"></td>'
                  when "sink"
                    @tabla += '<td class="sink"></td>'
                  else 
                    @tabla += '<td style="background-color:blue"></td>'
                  end
                end

            end
          end
          @tabla += '</tr>'
      end
      @tabla += '<tbody></table>'
      @tabla = @tabla.html_safe
    end
    
    get '/' do
      File.read(File.join('public', 'index.html'))
    end

    
    get 'batalla' do
      session[:divResultVisible] = false
      render 'batalla/index'
    end


    post 'crear_tablero' do
      @ancho = params[:ancho]
      @alto = params[:alto]
      session[:alto] = @alto
      session[:ancho] = @ancho
      session[:tablero] = Board.new @ancho.to_i,@alto.to_i

      session[:Disparos] = Matrix.build(@ancho.to_i,@alto.to_i){}

      crearTabla(0, 0, "", "")

      render 'batalla/index'
    end 

    post 'agregar_barco' do
        @coordenadas=params[:coordenadas_agregar]
        @radio_data = params[:checkLargo]
        @tablero = session[:tablero]
        a = @coordenadas.split(":")
        session[:x] = a[0].to_i
        session[:y]= a[1].to_i
        if @radio_data.eql?("largo") 
          @res_to_put_boat = @tablero.put_large_ship(@coordenadas)
        else
          @res_to_put_boat = @tablero.put_small_ship(@coordenadas)
        end
        session[:tablero] = @tablero
        
        crearTabla(0, 0, "", "")

        render 'batalla/index'
    end

    post 'verificar_celda' do
      session[:divResultVisible] = true
      @tablero = session[:tablero]
      @coordenadas=params[:coordenadas]
      a = @coordenadas.split(":")
      @x = a[0].to_i
      @y = a[1].to_i
      @res_to_shoot = @tablero.is_empty(@x,@y).to_s
      render 'batalla/index'
    end

    post 'disparar' do
      session[:divResultVisible] = true
      @tablero = session[:tablero]
      @coordenadas=params[:coord_to_shoot]
      @res_to_shoot = @tablero.shoot(@coordenadas)

      a = @coordenadas.split(":")
      @x = a[0].to_i
      @y = a[1].to_i
      crearTabla(@x, @y, "disparar", @res_to_shoot)

      render 'batalla/index'
    end 

  end
end
