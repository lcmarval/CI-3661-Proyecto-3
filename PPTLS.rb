Shoes.app do
	@contraPC = button "Jugar Contra la PC"
    @contraAmigo = button "Jugar Contra un Amigo"
    @note = para ""

    @contraPC.click {
      @note.replace "Decidiste Jugar contra la PC"
    }

    @contraAmigo.click {
      @note.replace "Decidiste Jugar contra un amigo"
    }
end