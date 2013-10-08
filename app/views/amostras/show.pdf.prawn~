font "Times-Roman"

image "public/image/logo.png", :position => :left, :height => 100, :width => 90, :at => [0, 735]
text_box  "Núcleo Global de Análise e Pesquisa\n\n", :style => :bold, :size => 18, :align => :center, :at => [0, 690]

text_box "Av. Amazonas, 4080-Sala 203-Prado-Belo Horizonte/MG\n"+
"CEP: 30.411-250 Telefax (31) 3313.1616\n"+
"Laboratório credenciado pelo MAPA para análises de microscopia do café e seus derivados\n"+
"Portaria No 217 de 14 de julho de 2009\n", 
:align => :center,
:size => 12,
:at => [0, 660],
:height => 100,
:width => 550


text_box  "Certificado de análise #{@amostra.certificado}", :style => :bold, :size => 16, :align => :center, :at => [0, 590]
move_down 160

pdf.font_size 10
font "Times-Roman"

# DADOS DO PEDIDO
table  [ ["<b>DADOS DA AMOSTRA</b>"] ], :cell_style => { :inline_format => true, :align => :center }, :column_widths => [500], :position => :center, :row_colors => ["EEEEEE"]
data = [ ["Produto: #{@amostra.produto}", "Marca: #{@amostra.marca}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Embalagem: #{@amostra.embalagem}", "Conteúdo: #{@amostra.conteudo}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Data de fabricação: #{@amostra.data_fabricacao}", "Data de validade: #{@amostra.data_validade}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Fabricante: #{@amostra.fabricante}", "CNPJ: #{@amostra.fabricante_CNPJ}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])

data = [ ["Endereço: #{@amostra.fabricante_rua}", "Bairro: #{@amostra.fabricante_bairro}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])

data = [ ["Cidade: #{@amostra.fabricante_cidade}", "UF: #{@amostra.fabricante_UF}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["CEP: #{@amostra.fabricante_CEP}", "Telefone: #{@amostra.fabricante_telefone}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Data de entrada no laboratório: #{@amostra.data_entrada.strftime("%d/%m/%Y")}", "Data de entrega do certificado: #{@amostra.data_saida.strftime("%d/%m/%Y")}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Amostragem: de responsabilidade do solicitante"] ]
table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])
if @amostra.descricao != ""
	data = [ ["Descrição: #{@amostra.descricao}"] ]
	table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])
end

#SOLICITANTE
move_down 30
table  [ ["<b>SOLICITANTE</b>"] ], :cell_style => { :inline_format => true, :align => :center }, :column_widths => [500], :position => :center, :row_colors => ["EEEEEE"]
data = [ ["Solicitante: #{@amostra.solicitante}", "CNPJ: #{@amostra.solicitante_CNPJ}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])

data = [ ["Endereço: #{@amostra.solicitante_rua}", "Bairro: #{@amostra.solicitante_bairro}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])

data = [ ["Cidade: #{@amostra.solicitante_cidade}", "UF: #{@amostra.solicitante_UF}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["CEP: #{@amostra.solicitante_CEP}", "Telefone: #{@amostra.solicitante_telefone}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])

#CARACTERÍSTICAS
if @amostra.caracteristicas != ""
	move_down 30
	table  [ ["<b>Características Organolépticas</b>"] ], :cell_style => { :inline_format => true, :align => :center }, :column_widths => [500], :position => :center, :row_colors => ["EEEEEE"]
	data = [ ["#{@amostra.caracteristicas}"] ]
	table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])
end

#RESULTADOS
@parametro_resultados = ParametroResultado.all

# MONTA UM VETOR TIPOS COM OS TIPOS DE ANALISES DIFERENTES QUE APARECEM NA AMOSTRA
tipos = Array.new
contem = 0
count = 0
@parametro_resultados.each do |resultado|
	contem = 0
	if resultado.amostra_id == @amostra.id
		for tipo in tipos
			if (resultado.tipo == tipo && resultado.tipo != "")
				contem = 1	
			end
		end
		if contem == 0
			tipos.insert(count, resultado.tipo)
			puts "Novo tipo: #{resultado.tipo} na posicao #{count} VER: #{tipos[count]}"
			count = count + 1
			
		end
	end
end

# PARA CADA TIPO, PERCORRE OS RESULTADOS IMPRIMINDO APENAS AQUELE TIPO
for tipo in tipos
	if !tipo.nil?
		move_down 30
		table  [ ["<b>Resultado de #{tipo}</b>"] ], :cell_style => { :inline_format => true, :align => :center }, :column_widths => [500], :position => :center, :row_colors => ["EEEEEE"]
	end

# PARA CADA TIPO, GERA VETOR DE METODOS E REFERENCIAS PARA AGRUPAR
	metRefs = Array.new
	contem = 0
	count = 0
	@parametro_resultados.each do |resultado|
		if (resultado.tipo == tipo)			
			contem = 0
			for metRef in metRefs
				if ("#{resultado.metodo_parametro}--#{resultado.referencia_parametro}" == metRef)
					contem = 1	
				end
			end
			if contem == 0
				if (!resultado.metodo_parametro.nil? && !resultado.referencia_parametro.nil?)
					metRefs.insert(count, "#{resultado.metodo_parametro}--#{resultado.referencia_parametro}")
					count = count + 1
				end
			end
		end
	end

	for metRef in metRefs

	# PARA CADA TIPO, PARA CADA MET/REF, IMPRIME OS DADOS AGRUPADOS
		tem_resultado = 0
		@parametro_resultados.each do |resultado|			
			if (resultado.tipo == tipo)			
				if ("#{resultado.metodo_parametro}--#{resultado.referencia_parametro}" == metRef)
				if resultado.amostra_id == @amostra.id	

					tem_resultado = 1	

					data = [ ["Parâmetro: #{resultado.parametro}"] ]
					table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"], :cell_style => {:borders => [:top, :left, :right]})

					data = [ ["Resultado: #{resultado.resultado}"] ]
					table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"], :cell_style => {:borders => [ :left, :right]})

					if resultado.valor_referencia_parametro != ""
						data = [ ["Valor de referência: #{resultado.valor_referencia_parametro}"] ]
						table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"], :cell_style => {:borders => [:left, :right]})
					end
					if resultado.conclusao != ""
						data = [ ["Conclusão: #{resultado.conclusao}"] ]
						table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"], :cell_style => {:borders => [:bottom, :left, :right]})
					end

			end
			end
			end
		end

		if tem_resultado == 1
		if metRef != "--"
			data = [ ["<b>Método: #{metRef[0, metRef.index('--')]}<b>"] ]
			table(data, :cell_style => {:inline_format => true}, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])

			data = [ ["<b>Referência: #{metRef[metRef.index('--')+2, metRef.length]}<b>"] ]
			table(data, :cell_style => {:inline_format => true}, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])

			tem_resultado = 0
		end
		end
	end

end


#OBSERVAÇÕES
move_down 40
if @amostra.observacoes == ""
	text  "Observação:<i> Resultado válido para a amostra analisada.</i>", :indent_paragraphs => 30, :inline_format => true
else
	text  "Observações:\n<i>Resultado válido para a amostra analisada.\n#{@amostra.observacoes}</i>", :indent_paragraphs => 30, :inline_format => true
end


# ASSINATURA
move_down 70
text  "__________________________________", :size => 16, :align => :center
text  "#{@amostra.assinatura} - #{@amostra.assinatura_tipo_conselho} #{@amostra.assinatura_numero_conselho}", :size => 14, :align => :center
text  "Responsável Técnico", :size => 14, :align => :center


# NÚMERO DA PÁGINA
number_pages "Página <page> / <total>", { :start_count_at => 0, :page_filter => :all, :at => [bounds.right - 80, pdf.bounds.bottom - 30], :align => :right, :size => 14 }

repeat :all do
	# LOGO
	image "public/image/logo2.png", :height => 40, :width => 35, :at => [bounds.left+5, pdf.bounds.bottom-15]
	# RUBRICA
	bounding_box([bounds.left, pdf.bounds.bottom-15], :width => 40, :height => 40) do
		transparent(1) { stroke_bounds }
	end
end
