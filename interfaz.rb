load 'Partida.rb'

Shoes.app(title: "Piedra,Papel,Tijeras,Lagarto,Spock") do
	@note = para ""
	@inicio = flow{
		caption "Seleccione un modo de juego "
		@aVsPc = button "Tu VS PC"
		@aVsA = button "Tu VS Amigo"
		@pcVsPc = button "PC VS PC"
	}

	@modos = flow{
		caption "Seleccione un tipo de juego "
		@rondas = button "Por Rondas"
		@alcanzar = button "Alcanzar"
		@reiniciar = button "Reiniciar"
	}
	@modos.hide()

	@estrategias = flow{
			caption "Seleccione una estrategia "
			@manual = button "Manual"
			@uniforme = button "Uniforme"
			@sesgado = button "Sesgado"
			@copiar = button "Copiar"
			@pensar = button "Pensar"
	}
	@estrategias.hide()

# Clicks Inicio
###########################################################################

	@aVsPc.click{
		@note.replace "Escogiste jugar contra la PC"
		@inicio.hide()
		modoPlay = 1
		@modos.show()	# todavia no estoy seguro donde se muestran los modos
		@reiniciar.click{ 
			@note.replace ""
			@modos.hide()
			@inicio.show()
			@f.delete()
		}	
	}

	@aVsA.click{
		@note.replace "Escogiste jugar contra un Amigo"
		@inicio.hide()
		modoPlay = 2
		@modos.show()
		@f = flow {
			@j1 = stack{
				@jug1 = banner "1"
				@marcador1 = stack width: 100 do
     				border black, strokewidth: 7
     				subtitle "0"
   				end
				@piedra = button("Piedra")  
				@papel = button("Papel")
				@tijeras = button("Tijeras") 
				@lagarto = button("Lagarto")
				@spock = button("Spock")
			}
			@j1.style(width: "50%")
			@j2 = stack{
				@jug2 = banner "2"
				@marcador2 = stack width: 100 do
     				border black, strokewidth: 7
     				subtitle "0"
   				end
				@marcador2 = border("0", 1)
				@piedra = button("Piedra")  
				@papel = button("Papel")
				@tijeras = button("Tijeras") 
				@lagarto = button("Lagarto")
				@spock = button("Spock")
			}
			@j2.style(width: "50%")
		}
		marcador1int = 0
		marcador2int = 0		
	}

	@pcVsPC.click{
		@note.replace "Escogiste PC contra PC"
		@inicio.hide()
		modoPlay = 3
		@modos.show()		
	}



	

end

=begin
	REUSaBles

@rondas.click{
	@modos.hide()
	@note.replace("Usted ha seleccionado por rondas")
	num_rondasS = ask("Cuantas rondas desea jugar?")
	num_rondas = num_rondasS.to_i
	jugarPorRondas(num_rondas,modoPlay)
}
	
@reiniciar.click{ 
	@note.replace ""
	@modos.hide()
	@inicio.show()
}
=end