load 'Jugadas.rb'   


class Estrategia

    def prox()
    end

    def to_s
        print self.class
    end

    def reset
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
            print ( "Indique un valor para su jugada (Manual) 
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
    attr_accessor :jugada

    def initialize(jugada)
        @jugada = jugada
    end

    def prox
        return @jugada     
    end
end

class Pensar < Estrategia
    attr_accessor :jugada

    def initialize
        @jugada = nil
    end

    def prox(jugadasAnterioresDelContrincante)

        suma = 0
        jugadasAnterioresDelContrincante.each {|i| suma = suma + i}

        if(suma == 0)
            
            _random = Random.new.rand(5) #Generamos el numero aleatorio entre 0 hasta 5
            
            case _random
                when 0
                    @jugada = Piedra.new
                when 1
                    @jugada = Papel.new
                when 2
                    @jugada = Tijeras.new
                when 3
                    @jugada = Lagarto.new
                when 4
                    @jugada = Spock.new
            end
        else
            _opcion = Random.new.rand(suma) #Generamos el numero aleatorio entre 0 y sum
            piedras = jugadasAnterioresDelContrincante[0]
            papeles = jugadasAnterioresDelContrincante[1]
            tijeras = jugadasAnterioresDelContrincante[2]
            lagartos = jugadasAnterioresDelContrincante[3]
            spocks = jugadasAnterioresDelContrincante[4]

            aux1 = piedras + papeles
            aux2 = aux1 + tijeras
            aux3 = aux2 + lagartos
            aux4 = aux3 + spocks


            if((0...piedras).include? (_opcion))
                @jugada = Piedra.new
            elsif((piedras...aux1).include? (_opcion))
                @jugada = Papel.new
            elsif((aux1...aux2).include? (_opcion))
                @jugada = Tijeras.new
            elsif((aux2...aux3).include? (_opcion))
                @jugada = Lagarto.new
            elsif((aux3...aux4).include? (_opcion))
                @jugada = Spock.new
            else
                print 'hola papi'
            end
        end

    end

end
