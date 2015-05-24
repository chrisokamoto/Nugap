module AmostrasHelper

	def amostra_wizard_steps_new
		["Abertura 1/2", "Abertura 2/2"]
	end

	def amostra_wizard_steps
		if !user_is_estagiario?
			["Abertura 1/2", "Abertura 2/2", "Inclusão de Resultados"]
		else
			["Abertura 1/2", "Abertura 2/2"]
		end	
	end

	
end
