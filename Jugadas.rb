# Clase que implementa las juagadas que se puedes realizar.
#
# Esta es una clase general de la que los casos heredan.
#
# De esta se general las subclases Piedra, Papel, Tijeras, Lagarto, Spock. 
class Jugada
    # Metodo que transforma los objetos en Strings
    def to_s
        # print self.class
    end

    # Función que determina el resultado de la jugada entre el invocante y la jugada j, 
    # correspondiente al contrincante, que es recibido como argumento. 
    # El resultado de puntos debe ser una tupla que representa la ganancia 
    # en puntos resultado de la jugada: 
    #* el primer elemento de la tupla representa la ganancia del invocante,
    #* mientras que el segundo elemento representa la ganancia del contrincante. 
    #Así, la tupla resultante debe ser [1,0], [0,1] o [0,0] dependiendo de los movimientos involucrados.
    def puntos(j)
    end
end

# Subclase de Jugada que da los posibles resultados cuando el invocante juega piedra
class Piedra < Jugada
    # Funcion que determina el resultado segun un input j
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

# Subclase de Jugada que da los posibles resultados cuando el invocante juega papel
class Papel < Jugada
    # Funcion que determina el resultado segun un input j
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

# Subclase de Jugada que da los posibles resultados cuando el invocante juega tijeras
class Tijeras < Jugada
    # Funcion que determina el resultado segun un input j
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

# Subclase de Jugada que da los posibles resultados cuando el invocante juega lagarto
class Lagarto < Jugada
    # Funcion que determina el resultado segun un input j
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

# Subclase de Jugada que da los posibles resultados cuando el invocante juega spock
class Spock < Jugada
    # Funcion que determina el resultado segun un input j
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


