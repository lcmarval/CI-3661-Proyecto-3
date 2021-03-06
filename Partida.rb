load 'Estrategias.rb'   

#La clase partida determina la realizacion del juego
class Partida

    attr_accessor :puntos
    
    def initialize(datos)

        @puntos = [0,0] #El arreglo que almacena los puntos de los jugadores

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
        @recuerdoDeJugadasDelJugador1 = [0,0,0,0,0] 
        @recuerdoDeJugadasDelJugador2 = [0,0,0,0,0]

    end

    #Metodo que suma los puntos de los jugadores luego de cada ronda de juego
    def sumarPuntos(resultado)
        @puntos = [@puntos,resultado].transpose.map { |x| x.reduce :+ }
    end

    #Metodo que informa quien gano cada ronda, si se le pasa flag = 1, dice quien gano todo el juego
    def ganador(puntos)

        if(puntos[0] < puntos[1])
            print "El Ganador es el jugador 2\n"
        elsif(puntos[0] > puntos[1])
            print "El Ganador es el jugador 1\n"
        else
            print "Esto es un empate!\n"
        end
    end

    def rondas(num_rondas)


        num_rondas.times do |ronda|

            if(@jugador1.class == Pensar)
                jugadaJugador1 = @jugador1.prox(@recuerdoDeJugadasDelJugador2)
            else
                jugadaJugador1 = @jugador1.prox
            end


            if(@jugador2.class == Pensar)
                jugadaJugador2 = @jugador2.prox(@recuerdoDeJugadasDelJugador1)
            else
                jugadaJugador2 = @jugador2.prox
            end

            #Asignamos el recuerdo de las jugadas anteriores de cada jugador
            recuerdoDeJugada(@recuerdoDeJugadasDelJugador1,jugadaJugador1)
            recuerdoDeJugada(@recuerdoDeJugadasDelJugador2,jugadaJugador2)

            resultado = jugadaJugador1.puntos(jugadaJugador2)
            # ganador(resultado)
            # sumarPuntos(resultado)
            print "Puntaje Actual: #{sumarPuntos(resultado)}\n" 
            
        end
        respuesta = { :Jugador1 => @puntos[0] , :Jugador2 => @puntos[1], :RondasJugadas => num_rondas}
        print "\n#{respuesta}\n\n"
        ganador(@puntos)
    end

    def alcanzar(num_puntos)

        while @puntos.detect {|i| i == num_puntos } == nil do

            if(@jugador1.class == Pensar)
                jugadaJugador1 = @jugador1.prox(@recuerdoDeJugadasDelJugador2)
            else
                jugadaJugador1 = @jugador1.prox
            end


            if(@jugador2.class == Pensar)
                jugadaJugador2 = @jugador2.prox(@recuerdoDeJugadasDelJugador1)
            else
                jugadaJugador2 = @jugador2.prox
            end

            #Asignamos el recuerdo de las jugadas anteriores de cada jugador
            recuerdoDeJugada(@recuerdoDeJugadasDelJugador1,jugadaJugador1)
            recuerdoDeJugada(@recuerdoDeJugadasDelJugador2,jugadaJugador2)

            resultado = jugadaJugador1.puntos(jugadaJugador2)
            # ganador(resultado)
            # sumarPuntos(resultado)
            print "Puntaje Actual: #{sumarPuntos(resultado)}\n" 
        end

        respuesta = { :Jugador1 => @puntos[0] , :Jugador2 => @puntos[1], :RondasJugadas => num_rondas}
        print "\n#{respuesta}\n\n"
        ganador(@puntos)
    end

    def recuerdoDeJugada(recuerdo,jugada)
        case jugada
            when Piedra
                recuerdo[0] += 1
            when Papel 
                recuerdo[1] += 1
            when Tijeras 
                recuerdo[2] += 1
            when Lagarto 
                recuerdo[3] += 1
            when Spock 
                recuerdo[4] += 1
        end
    end

    def reiniciar
        @puntos = [0,0] #El arreglo que almacena los puntos de los jugadores
        @recuerdoDeJugadasDelJugador1 = [0,0,0,0,0] 
        @recuerdoDeJugadasDelJugador2 = [0,0,0,0,0]
        @jugador1.reset
        @jugador2.reset

    end
end

#Funcion que determina como se jugara
def initial
    opcion =-1
    print ( "
        Seleccione un modo de juego
            1- Contra la PC ¬¬
            2- Contra un amigo >_< 
            3- Pc contra Pc -.-\")
        --->")

    opcion = gets.to_i
end

def jugarPorRondas(num_rondas,modoPlay)
    case modoPlay
        when 1
            print ( "
            Jugador 1 Seleccione una estrategia de juego
                1- Manual
                2- Uniforme
                3- Sesgada
                4- Copiar
                5- Pensar\n

            --->")

            opcionJugador1 = gets.to_i
            estrategiaJugador1 = selectEstrategia(opcionJugador1)

            estrategiaJugador2 = Pensar.new

            nuevaPartida = Partida.new( { :Jugador1 => estrategiaJugador1, :Jugador2 => estrategiaJugador2 } )
            nuevaPartida.rondas(num_rondas)

            jugarDeNuevo = 1
            while jugarDeNuevo==1 do

                print ( "
                Desea jugar más rondas?
                    1- Sí
                    2- No\n

                --->")

                jugarDeNuevo = gets.to_i

                case jugarDeNuevo
                    when 1
                        print("\tCuantas rondas adicionales desean jugar?\n")
                        print("\t--->")

                        num_rondas = gets.to_i
                        nuevaPartida.rondas(num_rondas)
                    when 2
                        print ( "
                            Desea reiniciar el juego?
                                1- Sí
                                2- No\n

                            --->")

                            reinicio = gets.to_i

                            case reinicio
                                when 1
                                    nuevaPartida.reiniciar
                                    nuevaPartida.rondas(num_rondas)
                            end
                    else 
                        raise ArgumentError.new('Entrada Invalida')
                end
            end
        when 2
            print ( "
            Jugador 1 Seleccione una estrategia de juego
                1- Manual
                2- Uniforme
                3- Sesgada
                4- Copiar
                5- Pensar\n

            --->")

            opcionJugador1 = gets.to_i
            estrategiaJugador1 = selectEstrategia(opcionJugador1)

            print ( "
            Jugador 2 Seleccione una estrategia de juego
                1- Manual
                2- Uniforme
                3- Sesgada
                4- Copiar
                5- Pensar\n

            --->")

            opcionJugador2 = gets.to_i
            estrategiaJugador2 = selectEstrategia(opcionJugador2)

            nuevaPartida = Partida.new( { :Jugador1 => estrategiaJugador1, :Jugador2 => estrategiaJugador2 } )
            nuevaPartida.rondas(num_rondas)

            jugarDeNuevo = 1
            while jugarDeNuevo==1 do

                print ( "
                Desea jugar más rondas?
                    1- Sí
                    2- No\n

                --->")

                jugarDeNuevo = gets.to_i

                case jugarDeNuevo
                    when 1
                        print("\tCuantas rondas adicionales desean jugar?\n")
                        print("\t--->")

                        num_rondas = gets.to_i
                        nuevaPartida.rondas(num_rondas)
                    when 2
                        print ( "
                        Desea reiniciar el juego?
                            1- Sí
                            2- No\n

                        --->")

                        reinicio = gets.to_i

                        case reinicio
                            when 1
                                nuevaPartida.reiniciar
                                nuevaPartida.rondas(num_rondas)
                        end
                    else 
                        raise ArgumentError.new('Entrada Invalida')
                end
            end

        when 3

            estrategiaJugador1 = Pensar.new

            estrategiaJugador2 = Pensar.new

            nuevaPartida = Partida.new( { :Jugador1 => estrategiaJugador1, :Jugador2 => estrategiaJugador2 } )
            nuevaPartida.rondas(num_rondas)

            jugarDeNuevo = 1
            while jugarDeNuevo==1 do

                print ( "
                Desea jugar más rondas?
                    1- Sí
                    2- No\n

                --->")

                jugarDeNuevo = gets.to_i

                case jugarDeNuevo
                    when 1
                        print("\tCuantas rondas adicionales desean jugar?\n")
                        print("\t--->")

                        num_rondas = gets.to_i
                        nuevaPartida.rondas(num_rondas)
                    when 2
                        print ( "
                        Desea reiniciar el juego?
                            1- Sí
                            2- No\n

                        --->")

                        reinicio = gets.to_i

                        case reinicio
                            when 1
                                nuevaPartida.reiniciar
                                nuevaPartida.rondas(num_rondas)

                        end
                    else 
                        raise ArgumentError.new('Entrada Invalida')
                end
            end

    end
end
def jugarPorPuntaje(num_puntos,modoPlay)
    case modoPlay
        when 1
            print ( "
            Jugador 1 Seleccione una estrategia de juego
                1- Manual
                2- Uniforme
                3- Sesgada
                4- Copiar
                5- Pensar\n

            --->")

            opcionJugador1 = gets.to_i
            estrategiaJugador1 = selectEstrategia(opcionJugador1)

            estrategiaJugador2 = Pensar.new

            nuevaPartida = Partida.new( { :Jugador1 => estrategiaJugador1, :Jugador2 => estrategiaJugador2 } )
            nuevaPartida.alcanzar(num_puntos)
            print ( "
            Desea reiniciar el juego?
                1- Sí
                2- No\n

            --->")

            reinicio = gets.to_i

            case reinicio
                when 1
                    nuevaPartida.reiniciar
                    nuevaPartida.alcanzar(num_puntos)

            end
        when 2
            print ( "
            Jugador 1 Seleccione una estrategia de juego
                1- Manual
                2- Uniforme
                3- Sesgada
                4- Copiar
                5- Pensar\n

            --->")

            opcionJugador1 = gets.to_i
            estrategiaJugador1 = selectEstrategia(opcionJugador1)

            print ( "
            Jugador 2 Seleccione una estrategia de juego
                1- Manual
                2- Uniforme
                3- Sesgada
                4- Copiar
                5- Pensar\n

            --->")

            opcionJugador2 = gets.to_i
            estrategiaJugador2 = selectEstrategia(opcionJugador2)

            nuevaPartida = Partida.new( { :Jugador1 => estrategiaJugador1, :Jugador2 => estrategiaJugador2 } )
            nuevaPartida.alcanzar(num_puntos)

            print ( "
            Desea reiniciar el juego?
                1- Sí
                2- No\n

            --->")

            reinicio = gets.to_i

            case reinicio
                when 1
                    nuevaPartida.reiniciar
                    nuevaPartida.alcanzar(num_puntos)

            end
        when 3
            estrategiaJugador1 = Pensar.new

            estrategiaJugador2 = Pensar.new

            nuevaPartida = Partida.new( { :Jugador1 => estrategiaJugador1, :Jugador2 => estrategiaJugador2 } )
            nuevaPartida.alcanzar(num_puntos)

            print ( "
            Desea reiniciar el juego?
                1- Sí
                2- No\n

            --->")

            reinicio = gets.to_i

            case reinicio
                when 1
                    nuevaPartida.reiniciar
                    nuevaPartida.alcanzar(num_puntos)

            end

    end
end

def seleccionUniforme

    estrategias = []
    opcion = -1

    while opcion<6 do
        print ( "\tIndique los valores de su estrategia 
            1- Piedra
            2- Papel
            3- Tijeras
            4- Lagarto
            5- Spock
            6- Listo, no más
            --->")

        opcion = gets.to_i
        case opcion
            when 1 
                estrategias.push(:Piedra)
            when 2 
                estrategias.push(:Papel)
            when 3 
                estrategias.push(:Tijeras)
            when 4
                estrategias.push(:Lagarto)
            when 5
                estrategias.push(:Spock)
        end
    end

    print("Tu estrategia es: #{estrategias}\n") 
    return estrategias
end

def seleccionSesgada

    estrategias = {}
    opcion = -1

    while opcion<6 do
        print ( "\tIndique los valores de su estrategia 
            1- Piedra
            2- Papel
            3- Tijeras
            4- Lagarto
            5- Spock
            6- Listo, no más
            --->")

        opcion = gets.to_i
        case opcion
            when 1
                print("\t Indique una probabilidad: ")
                probabilidad = gets.to_i 
                estrategias[:Piedra] = probabilidad
            when 2 
                print("\t Indique una probabilidad: ")
                probabilidad = gets.to_i 
                estrategias[:Papel] = probabilidad
            when 3 
                print("\t Indique una probabilidad: ")
                probabilidad = gets.to_i 
                estrategias[:Tijeras] = probabilidad
            when 4
                print("\t Indique una probabilidad: ")
                probabilidad = gets.to_i 
                estrategias[:Lagarto] = probabilidad
            when 5
                print("\t Indique una probabilidad: ")
                probabilidad = gets.to_i 
                estrategias[:Spock] = probabilidad
        end
    end

    print("Tu estrategia es: #{estrategias}\n") 
    return estrategias
end

def seleccionCopiar
    #Este metodo retornara un objeto siempre pues debe recordar siempre ese obejta, 
    #las instancias de copiar se crean con una instancia de estrategia como parametro

    print ( "\tIndique la jugada (recuerde que será eterna xD)
            1- Piedra
            2- Papel
            3- Tijeras
            4- Lagarto
            5- Spock
            --->")

        opcion = gets.to_i
        case opcion
            when 1
                Piedra.new
            when 2
                Papel.new
            when 3
                Tijeras.new
            when 4
                Lagarto.new
            when 5
                Spock.new
        end 
end

def selectEstrategia(opcion)
    case opcion
        when 1
            return Manual.new
        when 2
            return Uniforme.new(seleccionUniforme)
        when 3
            return Sesgada.new(seleccionSesgada)
        when 4
            return Copiar.new(seleccionCopiar)
        when 5
            return Pensar.new
        else 
            print("\n\tDebe seleccionar una opción entre 1 y 5\n\n")
    end 
end


##########################################################
##########################################################
##########################################################
##########################################################
#########                                 ################
#########         SECCION PRINCIPAL       ################
#########                                 ################
##########################################################
##########################################################
##########################################################
##########################################################


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
            #Por rondas
            print("\n\tPartida por Rondas\n\n")
            print("\tCuantas rondas desea jugar?\n")
            print("\t--->")

            num_rondas = gets.to_i
            jugarPorRondas(num_rondas,modoPlay)
        when 2
            #Hasta alcanzar
            print("\n\tPartida hasta alcanzar un puntaje\n\n")
            print("\tHasta cuantos puntos quieres jugar?\n")
            print("\t--->")

            num_puntos = gets.to_i
            jugarPorPuntaje(num_puntos,modoPlay)
        when 3
            # @jugada = Tijeras.new
        else 
            print("\n\tDebe seleccionar una opción entre 1 y 3\n\n")
    end 
end