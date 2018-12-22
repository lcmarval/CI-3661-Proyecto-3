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

        puts "\n #{@jugador1.prox} vs #{@jugador2.prox}"
    end

    def SumarPuntos(entrada)
        self.puntos = [self.puntos, entrada].transpose.map {|x| x.reduce(:+)}
    end

end

s1 = Uniforme.new([ :Piedra, :Papel, :Tijeras, :Lagarto, :Spock,:Lagarto,:Spock ])
s2 = Sesgada.new(
{ :Piedra => 2, :Papel => 5, :Tijeras => 4,
 :Lagarto => 3, :Spock => 1
})
m = Partida.new( { :Deepthought => s1, :Multivac => s2 } )

