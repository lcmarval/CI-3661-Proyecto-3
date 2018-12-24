Shoes.app(title:"Piedra, Papel, Tijeras ... Lagarto y Spock!! O.O"){

	@modoContraPc = nil
	@modoContraAmigo = nil
	@modoPcContraPc = nil
	@modoPlay = nil
	@jugarPorRondas = nil
	@jugarPorPuntos = nil
	@cantidadDeRondas = nil
	@selectorEstrategiaJugador1 = nil

	@jugador1_nombre = :jugador1
	@jugador1_estrategia = nil # Symbol
	@jugador1_strategy_stack = nil
	@jugador1_score = nil
    @jugador1_estrategia_selector = nil
    @jugador1_estrategia_text = nil
	@jugador1_uniform_options = [] # [[check,name]]
    @jugador1_bias_options = [] # [[check,name,n_text]]
    @jugador1_copy_options = nil # list_box
    @jugador1_icon = nil
    @jugador1_seleccion_manual = nil

    @jugador2_nombre = :jugador2
	@jugador2_estrategia = nil # Symbol
	@jugador2_strategy_stack = nil
	@jugador2_score = nil
    @jugador2_estrategia_selector = nil
    @jugador2_estrategia_text = nil
	@jugador2_uniform_options = [] # [[check,name]]
    @jugador2_bias_options = [] # [[check,name,n_text]]
    @jugador2_copy_options = nil # list_box
    @jugador2_icon = nil
    @jugador2_seleccion_manual = nil

    @jugadaManualJugado1 = false
	@jugadaManualJugado2 =false

	# Prop de juego
    @juego_iniciado = false
    @juego_partida = nil
    @juego_manuales = []
	
	# UI de Juego
    @iniciar_juego = nil
    @reiniciar_juego = nil
    @detener_juego = nil
    @rondas_juego = nil
    @modo_juego_selector = nil
    @modo_juego = nil
    @cantidad_editline_juego = nil
    @cantidad_juego = 1
    @iniciar_partida_juego = nil

	@estrategias = {
        "Manual" => :Manual, 
        "Uniforme" => :Uniforme, 
        "Sesgada"  => :Sesgada, 
        "Copiar"  => :Copiar, 
        "Pensar" => :Pensar}

    @jugadas = {
        "Piedra" => :Piedra,
        "Papel" => :Papel, 
        "Tijera" => :Tijera, 
        "Lagarto" => :Lagarto, 
        "Spock" => :Spock}


    

    def opcionesEstrategiaManual(jugador) 


	    @jugadas.keys.map { |name|
	        b = button name, margin_left: 4, width: 120
	        b.click {
	        	if(jugador == @jugador1_nombre)
	            	@jugador1_seleccion_manual =  @jugadas[name]
	            else
	            	@jugador2_seleccion_manual =  @jugadas[name]

	            end
	        }
	        b
	    }

	    if(jugador == @jugador1_nombre)
		    aceptar = button "Aceptar Jugada", margin_left: 4, width: 200
	        aceptar.click {
	            @jugadaManualJugado1 = true
	        }
	    else
	    	aceptar = button "Aceptar Jugada", margin_left: 4, width: 200
	        aceptar.click {
	            @jugadaManualJugado2 = true
	        }
	    end

    end

    ##################################################################################################
    ##################################################################################################
    ##################################################################################################
    ##############                                                              ######################
    ##############                   Interfaz Principal del Juego               ######################
    ##############                                                              ######################
    ##################################################################################################
    ##################################################################################################
    ##################################################################################################


	background("#FFFFFF")
	stack(width: '100%', height: '100%', scroll: true) do
		
		flow(margin: 10, width: '100%', margin_left: 12, margin_bottom: 0,) do
			@modoContraPc = button "Jugar contra la PC", width: '33%'
			@modoContraAmigo = button "Jugar Contra un Amigo", width: '33%'
			@modoPcContraPc = button "Pc vs Pc", width: '33%'
		end
		flow(margin: 10, width: '100%', margin_left: 12, margin_bottom: 0,) do
			@jugarPorRondas = button "Jugar por Rondas", width: '50%',state: "disabled"
			@jugarPorPuntos = button "Jugar por Puntos", width: '50%',state: "disabled"
		end
		flow(margin: 6, width: '100%', margin_left: 12, margin_bottom: 0) do
			para "Indique la cantidad: ", margin_left: 0
            @cantidadDeRondas = edit_line "1", state: "disabled", width: 40, margin_left: 8
            @cantidadDeRondas.change { |t|
                t.text = check_int(t.text()) 
            }
            # @iniciar_partida_juego = button "Iniciar Ronda", state: "disabled", margin_left: 4
            # @iniciar_partida_juego.click {
            #     num = @cantidadDeRondas.text().to_i().abs()
            #     if num > 0
            #         @cantidad_juego = num
            #         @juego_iniciado = true
            #         state_rounds_options("disabled")
            #         reset_manuals_options()
            #     else
            #         alert "Para Iniciar las Rondas se requiere un numero mayor a 0"
            #     end
            # }
        end
		flow(margin: 0) do
			#Lado izquierdo para el Jugador 1
			stack(width: '50%', margin: 0,  radius: 160) do
				background('#F44336')
				stack(margin: 0) do
					title("Jugador 1",align: "center",kerning: "5", stroke: "FFF" )
					subtitle("Cómo desea jugar?", size: "small", weight: "bold",align: "left",margin_left: 10,stroke: "FFF")

					@selectorEstrategiaJugador1 = list_box(items: @estrategias.keys,
                        width: 100,state: "disabled", choose: @estrategias.keys[0],margin_left: 10,margin_bottom: 6) do |list|

                        @jugador1_estrategia = @estrategias[list.text]

                        @jugador1_strategy_stack.hidden = @jugador1_estrategia == :Pensar
                        @jugador1_strategy_stack.clear()
                        if !@jugador1_strategy_stack.hidden
                            @jugador1_strategy_stack.append do
                            	case @jugador1_estrategia
                                    when :Manual
                                        opcionesEstrategiaManual(@jugador1_nombre)
                                end 
                            end
                        end
                    end
                    @jugador1_strategy_stack = stack(hidden: true)
				end
			end

			#Lado Derecho para el Jugador 2 3F51B5
			stack(width: '50%', margin: 0,  radius: 160) do
				background('#3F51B5')
				stack(margin: 0) do
					title("Jugador 2",align: "center",kerning: "5", stroke: "FFF" )
					subtitle("Cómo desea jugar?", size: "small", weight: "bold",align: "left",margin_left: 10,stroke: "FFF")

					@selectorEstrategiaJugador2 = list_box(items: @estrategias.keys,
                        width: 100,state: "disabled", choose: @estrategias.keys[0],margin_left: 10,margin_bottom: 6) do |list|

                        @jugador2_estrategia = @estrategias[list.text]

                        @jugador2_strategy_stack.hidden = @jugador2_estrategia == :Pensar
                        @jugador2_strategy_stack.clear()
                        if !@jugador2_strategy_stack.hidden
                            @jugador2_strategy_stack.append do
                            	case @jugador2_estrategia
                                    when :Manual
                                        opcionesEstrategiaManual(@jugador2_nombre)
                                end 
                            end
                        end
                    end
                    @jugador2_strategy_stack = stack(hidden: true)
				end
			end
		end
		flow(margin: 6, width: '100%', margin_left: 12, margin_bottom: 0) do
            @iniciar_partida_juego = button "Iniciar Ronda", state: "disabled", margin_left: 4
            @iniciar_partida_juego.click {
                num = @cantidadDeRondas.text().to_i().abs()
                if num > 0
                    @cantidad_juego = num
                    @juego_iniciado = true
                    state_rounds_options("disabled")
                    reset_manuals_options()
                else
                    alert "Para Iniciar las Rondas se requiere un numero mayor a 0"
                end
            }
        end
	end



	@modoContraAmigo.click {
		@modoPlay = 2
        @jugarPorRondas.state = nil
		@jugarPorPuntos.state = nil
    }

    @jugarPorRondas.click{
    	@cantidadDeRondas.state = nil
    	@selectorEstrategiaJugador1.state = nil
    }

    @jugarPorPuntos.click{
    	@cantidadDeRondas.state = nil
    	@selectorEstrategiaJugador1.state = nil
    }

}