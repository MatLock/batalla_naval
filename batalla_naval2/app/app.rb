require_relative 'models/Tablero'
require_relative 'models/Barco'


module Battleship
  class App < Padrino::Application
    register Padrino::Rendering
    register Padrino::Helpers
    enable :sessions
    
    get '/' do
        File.read(File.join('public', 'index.html'))
    end
    
    get 'mipagina' do
        session[:tablero] = nil
        session[:alto] = nil
        session[:ancho] = nil
        session[:errores] = ""
      render 'batalla/inicio'
    end


    post 'crearTablero' do
      @ancho = params[:ancho]
      @alto = params[:alto]
      session[:alto] = @alto
      session[:ancho] = @ancho
      session[:tablero] = Tablero.new(@ancho.to_i,@alto.to_i)
      render 'batalla/inicio'
    end   

    post 'posicionVacia' do
        coords = params[:coord]
        @tablero = session[:tablero]
        @respuesta = @tablero.posicionVacia(coords).to_s
        session[:tablero] = @tablero
        render 'batalla/inicio'
    end
     
    post 'ponerBarco' do
        @barco = params[:nombreBarco]
        @coordenadas=params[:coordenadas]
        @tamanio = params[:tamanio] 
        @tablero = session[:tablero]
        begin
            if(@tamanio.eql?('1'))
                @tablero.ponerBarcoEn(@coordenadas, BarcoChico.new(@barco))
            else
                @tablero.ponerBarcoEn(@coordenadas, BarcoLargo.new(@barco,@tamanio.to_i))
            end
        rescue Exception => e
            session[:errores] = session[:errores] +" , "+ e.message
        end
        session[:tablero] = @tablero
        render 'batalla/inicio'
    end

    post 'dispararEn' do
        @coordenadas = params[:coordDisparo]
        @tablero = session[:tablero]
        informe = @tablero.dispararEn(@coordenadas)
        session[:informe] = informe
        session[:tablero] = @tablero
        render 'batalla/inicio'
    end

    ##
    # Caching support
    #
    # register Padrino::Cache
    # enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
    # set :cache, Padrino::Cache::Store::Memory.new(50)
    # set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    ##
    # You can manage errors like:
    #
    #   error 404 do
    #     render 'errors/404'
    #   end
    #
    #   error 505 do
    #     render 'errors/505'
    #   end
    #
  end
end
