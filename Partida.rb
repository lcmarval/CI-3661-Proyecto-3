load 'Estrategias.rb'   

class Partida

    attr_accessor :puntos
    
    def initialize(datos)

        @puntos = [0,0]

        if(datos.keys.size !=2)
            raise ArgumentError.new('Deben haber exactamente dos jugadores')
        end

        datos.keys.each{|key| 
            if !(datos[key].is_a? (Estrategia))
                raise ArgumentError.new("Cada jugador debe venir asociado con una estrategia")
            end
        }

        @estrategias = datos.values
        @jugador1 = @estrategias[0]
        @jugador2 = @estrategias[1]

        # puts "\n #{@jugador1.prox} vs #{@jugador2.prox}"
    end

    def sumarPuntos(resultado)
        @puntos = [@puntos,resultado].transpose.map { |x| x.reduce :+ }
    end

    def jugarPorRondas(num_rondas)

        num_rondas.times do |ronda|

            jugadaJugador1 = @jugador1.prox
            jugadaJugador2 = @jugador2.prox

            resultado = jugadaJugador1.puntos(jugadaJugador2)
            print resultado
            if(resultado[0] < resultado[1])
                print "Gana jugador 2\n"
            elsif(resultado[0] > resultado[1])
                print "Gana jugador 1\n"
            else
                print "Empate\n"
            end
            print "Puntaje Actual: #{sumarPuntos(resultado)}\n" 
            
        end

        if(@puntos[0] < @puntos[1])
            print "El Ganador es el jugador 2\n"
        elsif(@puntos[0] > @puntos[1])
            print "El Ganador es el jugador 1\n"
        else
            print "Esto es un empate!\n"
        end
    end

end

# s1 = Uniforme.new([ :Piedra, :Papel, :Tijeras, :Lagarto, :Spock,:Lagarto,:Spock ])
# s2 = Sesgada.new(
# { :Piedra => 2, :Papel => 5, :Tijeras => 4,
#  :Lagarto => 3, :Spock => 1
# })
# s3 = Manual.new
# m = Partida.new( { :Deepthought => s3, :Multivac => s2 } )


#Funcion que determina como se jugara
def initial
    opcion =-1
    print ( "
        Seleccione un modo de juego
            1- Contra la PC ¬¬
            2- Contra un amigo >_< \")
        --->")

    opcion = gets.to_i

end

def rondas(num_rondas,modoPlay)
    case modoPlay
        when 1
            #Rondas contra el PC
        when 2
            print ( "
            Jugador 1 Seleccione una estrategia de juego
                1- Manual
                2- Uniforme
                3- Sesgada
                4- Copiar\n

            --->")

            opcionJugador1 = gets.to_i
            estrategiaJugador1 = selectEstrategia(opcionJugador1)

            print ( "
            Jugador 2 Seleccione una estrategia de juego
                1- Manual
                2- Uniforme
                3- Sesgada
                4- Copiar\n

            --->")

            opcionJugador2 = gets.to_i
            estrategiaJugador2 = selectEstrategia(opcionJugador2)

            nuevaPartida = Partida.new( { :Jugador1 => estrategiaJugador1, :Jugador2 => estrategiaJugador2 } )
            nuevaPartida.jugarPorRondas(num_rondas)
            # print "#{estrategiaJugador1} vs #{estrategiaJugador2}"

    end
end

def selectEstrategia(opcion)
    case opcion
        when 1
            #Manual
            return Manual.new
        when 2
            # @jugada = Papel.new
        when 3
            # @jugada = Tijeras.new
        else 
            print("\n\tDebe seleccionar una opción entre 1 y 5\n\n")
    end 
end

print("\n\tPiedra, Papel, Tijeras... Lagarto y Spock!!!\n\n")

modoPlay = initial  #Esta variable almacena el modo de juego
opcion =-1

while opcion<1 or opcion>3 do

    print ( "
        Seleccione un modo de juego
            1- Por Ronda =D
            2- Alcanzar \")
            3- Reiniciar Juego\n

        --->")

    opcion = gets.to_i
    rondas = -1
    case opcion
        when 1
            print("\n\tPartida por Rondas\n\n")
            print("\tCuantas rondas desea jugar?\n")
            print("\t--->")

            num_rondas = gets.to_i
            rondas(num_rondas,modoPlay)
        when 2
            # @jugada = Papel.new
        when 3
            # @jugada = Tijeras.new
        else 
            print("\n\tDebe seleccionar una opción entre 1 y 3\n\n")
    end 
end