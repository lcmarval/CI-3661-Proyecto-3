load 'Jugadas.rb'   

class Estrategia

    def prox()
    end

    def to_s
        print self.class
    end

    def reset
        print 'Aun no me reseteo'
    end

end

class Manual < Estrategia
    attr_accessor :movimiento
    attr_accessor :jugada

    def initialize
        @jugada = nil
    end

    def prox
        opcion = -1
        while opcion<1 or opcion>5 do
            print ( "Indique un valor para su jugada 
                    1- Piedra
                    2- Papel
                    3- Tijeras
                    4- Lagarto
                    5- Spock\n")
            opcion = gets.to_i
        end
        @jugada = nil
        case opcion
            when 1
                @jugada = Piedra.new
            when 2
                @jugada = Papel.new
            when 3
                @jugada = Tijeras.new
            when 4
                @jugada = Lagarto.new
            when 5
                @jugada = Spock.new
            else 
                @jugada = Jugada.new
        end     
    end

end

class Uniforme < Estrategia
    attr_accessor :movimientos
    attr_accessor :jugada
    #Se inicia la estrategia Uniforme, es necesario que sea un arreglo de Symbols
    def initialize(movimientos)

        @jugada = nil
        #Validamos que sea un arreglo, en caso contrario retornamos un error
        if (movimientos.class == Array) 

            #Validamos que que exista al menos una opciona ne el arreglo
            if(movimientos.length < 1)
                raise ArgumentError.new('Debe haber al menos una Estrategia con este modo.')
            else
                #Asignamos el atributo
                @movimientos = movimientos & movimientos #Aqui intersectamos para eliminar las repetecionesz
            end
        else
            raise ArgumentError.new('Debe haber al menos una Estrategia con este modo.')
        end
    end

    #Redifinimos el metodo para seleccionar la jugada
    def prox
        #Se selecciona una opcion de jugada random, con probabilidad uniforme para cada opcion
        _random = Random.new.rand(@movimientos.length) #Generamos el numero aleatorio entre 0 y el tamaño del array
        _opcion = @movimientos[_random] #Asignamos la opcion de juego

        case _opcion
            when :Piedra
                @jugada = Piedra.new
            when :Papel
                @jugada = Papel.new
            when :Tijeras
                @jugada = Tijeras.new
            when :Lagarto
                @jugada = Lagarto.new
            when :Spock
                @jugada = Spock.new
            else 
                raise ArgumentError.new('Jugada invalida.')
        end
    end
end

class Sesgada < Estrategia

    attr_accessor :movimientos
    attr_accessor :aux_movimientos
    attr_accessor :jugada
    #Se inicia la estrategia Sesgada, es necesario que sea un map
    def initialize(movimientos)

        @jugada = nil

        #Validamos que sea un Hash, en caso contrario retornamos un error
        if (movimientos.class == Hash)

            @movimientos = movimientos.keys & movimientos.keys #aca tenemos las jugadas sin repetir, este paso puede obviarse
            
            @aux_movimientos = [] #Iniciamos los movimientos sin nada
            #Validamos que que exista al menos una opciona en los arreglos
            if(@movimientos.length < 1)
                raise ArgumentError.new('Debe haber al menos una Estrategia con este modo.')
            elsif(movimientos.keys.size < 1)
                raise ArgumentError.new('Debe haber al menos una probabilidad en este metodo.')
            else

                #Creamos un arreglo que combine las probabilidades con los movimientos
                aux = [movimientos.keys,movimientos.values].transpose

                #Por cada posicion de ese arreglo, anexamos a movimientos la jugada la cantidad de veces que diga la probabilidad
                aux.each do |movimiento|
                    movimiento[1].times do |num|
                        @aux_movimientos.push(movimiento[0])
                    end
                end
            end
        else
            raise ArgumentError.new('Debe haber al menos una Estrategia con este modo1.')
        end
    end

    def prox
        
        _random = Random.new.rand(@aux_movimientos.length) #Generamos el numero aleatorio entre 0 y el tamaño del array
        _opcion = @aux_movimientos[_random] #Asignamos la opcion de juego
        
        case _opcion
            when :Piedra
                @jugada = Piedra.new
            when :Papel
                @jugada = Papel.new
            when :Tijeras
                @jugada = Tijeras.new
            when :Lagarto
                @jugada = Lagarto.new
            when :Spock
                @jugada = Spock.new
            else 
                raise ArgumentError.new('Jugada invalida.')
        end
    end
end

class Copiar < Estrategia
    attr_accessor :movimiento
    def initialize(movimiento)
        @movimiento = movimiento
        @jugada = nil
    end

    def prox

        case @movimiento
            when Piedra
                @jugada = Piedra.new
            when Papel
                @jugada = Papel.new
            when Tijeras
                @jugada = Tijeras.new
            when Lagarto
                @jugada = Lagarto.new
            when Spock
                @jugada = Spock.new
            else 
                @jugada = Jugada.new
        end 

        if(@jugada != nil)
            @movimiento = @jugada
        end       
    end
end


# _uniforme = Uniforme.new([ :Piedra, :Papel, :Tijeras, :Lagarto, :Spock,:Lagarto,:Spock ])
# _uniforme.prox

# b = Sesgada.new(
# { :Piedra => 2, :Papel => 5, :Tijeras => 4,
#  :Lagarto => 3, :Spock => 1
# })
# b.prox
