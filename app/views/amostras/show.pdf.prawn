#image "public/image/logo2.png", :position => :center, :vposition => :center
image "public/image/logo.png", :position => :left, :height => 60, :width => 55, :at => [0, 700]

text_box  "Núcleo Global de Análise e Pesquisa\n\n", :style => :bold, :size => 18, :align => :center, :at => [0, 687]

text_box "Av. Amazonas, 4080-Sala 203-Prado-Belo Horizonte/MG\n"+
"CEP: 30.411-250 Telefax (31) 3313.1616\n"+
"Laboratório credenciado pelo MAPA para análises de microscopia do café e seus derivados\n"+
"Portaria No 217 de 14 de julho de 2009\n", 
:align => :center,
:size => 12,
:at => [0, 663],
:height => 100,
:width => 550


text_box  "Certificado de análise #{@amostra.certificado}", :style => :bold, :size => 16, :align => :center, :at => [0, 590]
move_down 170
pdf.font_size 11


# DADOS DO PEDIDO
table  [ ["<b>DADOS DA AMOSTRA</b>"] ], :cell_style => { :inline_format => true, :align => :center }, :column_widths => [500], :position => :center, :row_colors => ["EEEEEE"]
data = [ ["Produto: #{@amostra.produto}", "Marca: #{@amostra.marca}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Embalagem: #{@amostra.embalagem}", "Conteúdo: #{@amostra.conteudo} #{@amostra.unidade}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Data de fabricação: #{@amostra.data_fabricacao.strftime("%d/%m/%Y")}", "Data de Validade: #{@amostra.data_validade.strftime("%d/%m/%Y")}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Fabricante: #{@amostra.fabricante}", "CNPJ: #{@amostra.fabricante_CNPJ}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Endereço: #{@amostra.fabricante_rua}, #{@amostra.fabricante_numero}", "Bairro: #{@amostra.fabricante_bairro}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Cidade: #{@amostra.fabricante_cidade}", "UF: #{@amostra.fabricante_UF}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["CEP: #{@amostra.fabricante_CEP}", "Telefone: #{@amostra.fabricante_telefone}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Data de entrada no laboratório: #{@amostra.data_entrada.strftime("%d/%m/%Y")}", "Data de entrega do certificado:: #{@amostra.data_saida.strftime("%d/%m/%Y")}"] ]
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
data = [ ["Endereço: #{@amostra.solicitante_rua}, #{@amostra.solicitante_numero}", "Bairro: #{@amostra.solicitante_bairro}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Cidade: #{@amostra.solicitante_cidade}", "UF: #{@amostra.solicitante_UF}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["CEP: #{@amostra.solicitante_CEP}", "Telefone: #{@amostra.solicitante_telefone}"] ]
table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])

#CARACTERÍSTICAS
if @amostra.caracteristicas != ""
	move_down 30
	table  [ ["<b>CARACTERÍSTICAS ORGANOLÉPTICAS</b>"] ], :cell_style => { :inline_format => true, :align => :center }, :column_widths => [500], :position => :center, :row_colors => ["EEEEEE"]
	data = [ ["#{@amostra.caracteristicas}"] ]
	table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])
end

#RESULTADOS
@parametro_resultados = ParametroResultado.all
@parametro_resultados.each do |resultado|
	if resultado.amostra_id == @amostra.id		
		parametro = Parametro.find_by_nome(resultado.parametro)
		move_down 30
		table  [ ["<b>Resultado de #{resultado.tipo}</b>"] ], :cell_style => { :inline_format => true, :align => :center }, :column_widths => [500], :position => :center, :row_colors => ["EEEEEE"]

		data = [ ["Parâmetro: #{resultado.parametro}"] ]
		table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])

		data = [ ["Resultado: #{resultado.resultado}"] ]
		table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])

		data = [ ["Método: #{parametro.metodo}"] ]
		table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])

		data = [ ["Referência: #{parametro.referencia}"] ]
		table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])

		#if parametro.valor_maximo.to_s.strip.length != 0 && parametro.valor_minimo.to_s.strip.length != 0
		#	data = [ ["Valor máximo do parâmetro: #{parametro.valor_maximo}", "Valor mínimo do parâmetro: #{parametro.valor_minimo}"] ]
		#	table(data, :column_widths => [250, 250], :position => :center, :row_colors => ["FFFFFF"])
		#end
		#if parametro.valor_maximo.to_s.strip.length == 0 && parametro.valor_minimo.to_s.strip.length != 0
		#	data = [ ["Valor mínimo do parâmetro: #{parametro.valor_minimo}"] ]
		#	table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])
		#end
		#if parametro.valor_maximo.to_s.strip.length != 0 && parametro.valor_minimo.to_s.strip.length == 0
		#	data = [ ["Valor máximo do parâmetro: #{parametro.valor_maximo}"] ]
		#	table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])
		#end

# Descomentar quando criar os campos
		if parametro.valor_referencia != ""
			data = [ ["Valor de referência: #{parametro.valor_referencia}"] ]
			table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])
		end
		if resultado.conclusao != ""
			data = [ ["Conclusão: #{resultado.conclusao}"] ]
			table(data, :column_widths => [500], :position => :center, :row_colors => ["FFFFFF"])
		end
		
	end
end

#OBSERVAÇÕES
move_down 40
if @amostra.observacoes == ""
	text  "Obervação:<i> Resultado válido para a amostra analisada.</i>", :indent_paragraphs => 30, :inline_format => true
else
	text  "Obervações:\n<i>Resultado válido para a amostra analisada.\n#{@amostra.observacoes}</i>", :indent_paragraphs => 30, :inline_format => true
end


# ASSINATURA
move_down 70
text  "__________________________________", :size => 16, :align => :center
text  "#{@amostra.assinatura} - #{@amostra.assinatura_tipo_conselho} #{@amostra.assinatura_numero_conselho}", :size => 14, :align => :center
text  "Responsável Técnico", :size => 14, :align => :center


# NÚMERO DA PÁGINA
pdf.bounding_box([pdf.bounds.right - 50,pdf.bounds.bottom + 10], :width => 60, :height => 20) do
	pagecount = pdf.page_count
	pdf.text "Página #{pagecount}"
end

