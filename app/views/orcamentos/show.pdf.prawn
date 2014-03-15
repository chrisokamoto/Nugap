Prawn::Document.new() do |pdf|
	font "Times-Roman"

	image "public/image/logo.png", :position => :left, :height => 100, :width => 90, :at => [30, 800]
	text_box  "NÚCLEO GLOBAL DE ANÁLISE E PESQUISA\n\n", :style => :bold, :size => 14, :align => :center, :at => [70, 780]

	text_box "Av. Amazonas, 4080, Sala 203-Prado-Belo Horizonte/MG-CEP: 30.411-250-Telefax (31) 3313.1616\n"+
	"Laboratório credenciado pelo MAPA para análises de microscopia do café e seus derivados\n"+
	"Portaria Nº 217 de 14 de julho de 2009\n", 
	:align => :center,
	:size => 10,
	:at => [70, 755],
	:height => 100,
	:width => 550

	move_down 105
	if ("#{@orcamento.status}" == "Aceito")
		if !("#{@orcamento.data}" == "")
			text_box  "PRESTAÇÃO DE SERVIÇO - N° #{@orcamento.numero} - Data: #{@orcamento.data}", :style => :bold, :size => 14, :align => :center, :at => [0, 685]	
		elsif ("#{@orcamento.data}" == "")
			text_box  "PRESTAÇÃO DE SERVIÇO - N° #{@orcamento.numero}", :style => :bold, :size => 14, :align => :center, :at => [0, 685]	
		end		
	elsif ("#{@orcamento.status}" == "Não Aceito")
		if !("#{@orcamento.data}" == "")
			text  "PROPOSTA DE PRESTAÇÃO DE SERVIÇO - N° #{@orcamento.numero} - Data: #{@orcamento.data}", :style => :bold, :size => 14, :align => :center
		elsif ("#{@orcamento.data}" == "")
			text  "PROPOSTA DE PRESTAÇÃO DE SERVIÇO - N° #{@orcamento.numero}", :style => :bold, :size => 14, :align => :center
		end
	end	

	pdf.font_size 10
	font "Times-Roman"

	move_down 20

	# DADOS DO ORCAMENTO	
	if !("#{@orcamento.empresa_solicitante}" == "")
		text  "<b>Solicitante: </b>#{@orcamento.empresa_solicitante}", :size => 10, :indent_paragraphs => 30, :inline_format => true	
	end

	empresa = Empresa.find_by_nome(@orcamento.empresa_solicitante)
	dados_empresa = ""
	entrou = 0

	if !(empresa.nil?)
		if !(empresa.CNPJ.nil? || empresa.CNPJ == "")
			entrou = 1
			dados_empresa += "<b>CNPJ:</b> #{empresa.CNPJ} \n"
		end	
		if !(empresa.rua.nil? || empresa.rua == "")
			entrou = 1
			dados_empresa += "<b>Endereço:</b> #{empresa.rua} - Bairro: #{empresa.bairro} - #{empresa.cidade}/#{empresa.UF} - CEP: #{empresa.CEP}"
		end		
		if entrou == 1
			text  dados_empresa, :size => 10, :indent_paragraphs => 30, :inline_format => true
		end				
	end
	if !("#{@orcamento.pessoa_solicitante}" == "")
		text  "<b>A/C:</b> #{@orcamento.pessoa_solicitante}", :size => 10, :indent_paragraphs => 30, :inline_format => true		
	end
	if !("#{@orcamento.telefone}" == "")
		text  "<b>Telefone:</b> #{@orcamento.telefone}", :size => 10, :indent_paragraphs => 30, :inline_format => true	
	end
	if !("#{@orcamento.email}" == "")
		text  "<b>Email:</b> #{@orcamento.email}", :size => 10, :indent_paragraphs => 30, :inline_format => true
	end
	move_down 5

	#DADOS DO PRODUTO
	@servico_orcamentos = ServicoOrcamento.find_all_by_orcamento_id(@orcamento.id)	

	# MONTA UM VETOR DE PRODUTOS COM OS PRODUTOS DIFERENTES QUE APARECEM NO ORCAMENTO
	produtos = Array.new
	analises = Array.new
	metodos = Array.new

	countProduto = 0
	countAnalise = 0
	countMetodo = 0

	@servico_orcamentos.each do |servico|
		contemProduto = 0
		contemAnalise = 0
		contemMetodo = 0
		
		for produto in produtos
			if (servico.produto == produto && servico.produto != "")
				contemProduto = 1	
				for analise in analises
					if(servico.analise == analise && servico.analise != "")
						contemAnalise = 1
						for metodo in metodos
							if(servico.metodo == metodo && servico.metodo != "")
							contemMetodo = 1
						end
				end
					end
				end
			end
		end
		if contemProduto == 0
			produtos.insert(countProduto, servico.produto)				
			countProduto = countProduto + 1				
		end		
		if contemAnalise == 0
			analises.insert(countAnalise, servico.analise)				
			countAnalise = countAnalise + 1				
		end	
		if contemMetodo == 0
			metodos.insert(countMetodo, servico.metodo)				
			countMetodo = countMetodo + 1				
		end	

	end

	# PARA CADA PRODUTO, PERCORRE OS RESULTADOS IMPRIMINDO APENAS AQUELE PRODUTO
	for produto in produtos		
		total = 0.0
		for analise in analises
			entrouMetodo = 0
			for metodo in metodos				
				if !produto.nil? && !analise.nil?
					@servico = ServicoOrcamento.where(:produto => produto, :analise => analise, :metodo => metodo,  :orcamento_id => @orcamento.id)				
					if @servico.exists? 
						move_down 7
						produtoNovo = produto.dup
						produtoNovo.gsub!("á", "Á")
						produtoNovo.gsub!("à", "À")
						produtoNovo.gsub!("ã", "Ã")
						produtoNovo.gsub!("â", "Â")
						produtoNovo.gsub!("é", "É")
						produtoNovo.gsub!("ê", "Ê")
						produtoNovo.gsub!("í", "Í")
						produtoNovo.gsub!("ó", "Ó")
						produtoNovo.gsub!("õ", "Õ")
						produtoNovo.gsub!("ô", "Ô")
						produtoNovo.gsub!("ú", "Ú")
						produtoNovo.gsub!("ç", "Ç")

						analiseNova = analise.dup
						analiseNova.gsub!("á", "Á")
						analiseNova.gsub!("à", "À")
						analiseNova.gsub!("ã", "Ã")
						analiseNova.gsub!("â", "Â")
						analiseNova.gsub!("é", "É")
						analiseNova.gsub!("ê", "Ê")
						analiseNova.gsub!("í", "Í")
						analiseNova.gsub!("ó", "Ó")
						analiseNova.gsub!("õ", "Õ")
						analiseNova.gsub!("ô", "Ô")
						analiseNova.gsub!("ú", "Ú")
						analiseNova.gsub!("ç", "Ç")	

						metodoNovo = metodo.dup										
						
						if(entrouMetodo == 0)
							table  [ ["<b>PRODUTO: #{produtoNovo.upcase} - ANÁLISE: #{analiseNova.upcase}</b>"] ], :cell_style => { :inline_format => true, :align => :center, :border_width => 0.5, :size => 10 }, :column_widths => [540], :position => :center, :row_colors => ["EEEEEE"]
						end

						entrouMetodo = 1

						table  [ ["<b>Método: #{metodoNovo}</b>"] ], :cell_style => { :inline_format => true, :align => :left, :border_width => 0.5, :size => 10 }, :column_widths => [540], :position => :center

						data = [ ["<b>Parâmetro</b>","<b>N° de Amostras</b>","<b>Valor Unitário</b>","<b>Valor Total</b>"] ]
							table(data, :column_widths => [135,135,135,135], :position => :center, :row_colors => ["FFFFFF"], :cell_style => {:inline_format => true, :border_width => 0.5, :align => :center, :size => 10})
						for parametro in @servico
							total += parametro.valor_total
							data = [ ["#{parametro.parametro}","#{parametro.qtd_amostra}","#{parametro.valor_unitario}","#{parametro.valor_total}"] ]
							table(data, :column_widths => [135,135,135,135], :position => :center, :row_colors => ["FFFFFF"], :cell_style => {:inline_format => true, :border_width => 0.5, :align => :center, :size => 10})
						end
					end
				end
			end
		end
		data = [ ["Total do Serviço: #{total.round(2)}"] ]
						table(data, :column_widths => [540], :position => :center, :row_colors => ["FFFFFF"], :cell_style => {:inline_format => true, :border_width => 0.5, :size => 10})
		move_down 5
	end

	move_down 10
	
	if !("#{@orcamento.observacao}" == "")
		text  "<b>Observação:</b> #{@orcamento.observacao}", :size => 10, :indent_paragraphs => 30, :inline_format => true
	end
	if !("#{@orcamento.quantidade}" == "")
		text  "<b>Quantidade:</b> #{@orcamento.quantidade}", :size => 10, :indent_paragraphs => 30, :inline_format => true
	end

	

	if (cursor < 180)
		start_new_page
		move_down 20
	end

	if !("#{@orcamento.ir}" == "0.0")
		text  "<b>IR:</b> #{@orcamento.ir}", :size => 10, :indent_paragraphs => 30, :inline_format => true
	end
	if !("#{@orcamento.pis}" == "0.0")
		text  "<b>PIS:</b> #{@orcamento.pis}", :size => 10, :indent_paragraphs => 30, :inline_format => true
	end
	if !("#{@orcamento.cssl}" == "0.0")
		text  "<b>CSSL:</b> #{@orcamento.cssl}", :size => 10, :indent_paragraphs => 30, :inline_format => true
	end
	if !("#{@orcamento.cofins}" == "0.0")
		text  "<b>COFINS:</b> #{@orcamento.cofins}", :size => 10, :indent_paragraphs => 30, :inline_format => true
	end

	
	
	
	if !(("#{@orcamento.desconto}" == "0") || (@orcamento.desconto.nil? ))
		valor_desconto =  (@orcamento.valor_bruto * @orcamento.desconto / 100.0).round(2)

		text  "<b>Desconto #{@orcamento.desconto}%:</b> #{valor_desconto}", :size => 10, :indent_paragraphs => 30, :inline_format => true	
	end
	if !("#{@orcamento.prazo}" == "")
		text  "<b>Prazo de Entrega:</b> #{@orcamento.prazo}", :size => 10, :indent_paragraphs => 30, :inline_format => true
	end
	text  "<b>Forma de Pagamento:</b> #{@orcamento.pagamento}", :size => 10, :indent_paragraphs => 30, :inline_format => true
	#text  "<b>Total Orçamento sem Impostos:</b> #{@orcamento.valor_bruto}", :size => 10, indent_paragraphs => 30, :inline_format => true

	if ("#{@orcamento.pagamento}" == "Depósito" || "#{@orcamento.pagamento}" == "Depósito/Transferência")
		text "Banco Itaú - Agência 5197 - C/C 04848-0 - Favorecido - Núcleo Global de Análise e Pesquisa - CNPJ: 01.889.995/0001-56", :size => 10, :indent_paragraphs => 30, :inline_format => true
	end

	move_down 25
	

	text  "<b>TOTAL A PAGAR:</b> R$ #{@orcamento.total_pagar}", :size => 10, :indent_paragraphs => 30, :inline_format => true


	# NÚMERO DA PÁGINA
	number_pages "Página <page> / <total>", { :start_count_at => 0, :page_filter => :all, :at => [400, pdf.bounds.bottom], :align => :center, :size => 9 }

	repeat :all do	
		text_box  "www.nugap.com.br - Fone: (31) 3313-1616 - e-mail: nugap@nugap.com.br", :size => 10, :align => :left, :at => [30, 9]			
	end
end

