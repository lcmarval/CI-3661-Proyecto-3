# Clase que implementa las juagadas que se puedes realizar.
#   Esta es una clase general de la que los casos heredan.
class Jugada
    
    def to_s
        # print self.class
    end

    def puntos(j)
    end
end

class Piedra < Jugada
    def puntos(j)
        case j
            #La piedra le gana a las tijeras y al lagarto
            when Tijeras, Lagarto
                return [1,0]

            #Piedra empata con Piedra
            when Piedra
                return [0,0]

            # La piedra pierde ante el papel y spock
            else
                return [0,1]
        end
    end
end

class Papel < Jugada
    def puntos(j)
        case j
            #Papel le gana a Piedra y a Spock
            when Piedra, Spock
                return [1,0]

            #Papel empata con Papel
            when Papel
                return [0,0]
            #Papel priera contra Tijeras y Lagarto
            else
                return [0,1]
        end
    end
end

class Tijeras < Jugada
    
    def puntos(j)
        case j

            #Tijeras le gana a Papel y Lagarto
            when Papel, Lagarto
                return [1,0]

            #Tijeras empata con Tijeras
            when Tijeras
                return [0,0]

            #Tijeras pierda ante Piedra y Spock
            else
                return [0,1]
        end
    end
end

class Lagarto < Jugada
    
    def puntos(j)
        case j

            #Lagarto le gana a Papel y Spock
            when Papel, Spock
                return [1,0]

            #Lagarto empata con lagarto
            when Lagarto
                return [0,0]

            #Lagarto pierde ante Piedra y Tijeras 
            else
                return [0,1]
        end
    end
end

class Spock < Jugada
    def puntos(j)
        case j

            #Spock le gana a tijeras y Piedras
            when Tijeras, Piedra
                return [1,0]

            #Spock empata con Spcok
            when Spock
                return [0,0]

            #Spocok pierde ante Lagarto y Papel
            else
                return [0,1]
        end
    end
end


