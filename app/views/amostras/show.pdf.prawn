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


text_box  "Certificado de análise #{@amostra.certificado}", :style => :bold, :size => 14, :align => :center, :at => [0, 705]
move_down 95

pdf.font_size 10
font "Times-Roman"

# DADOS DO PEDIDO
table  [ ["<b>DADOS DA AMOSTRA</b>"] ], :cell_style => { :inline_format => true, :align => :center, :border_width => 0.5}, :column_widths => [540], :position => :center, :row_colors => ["EEEEEE"]
data = [ ["Produto: #{@amostra.produto}", "Marca: #{@amostra.marca}"] ]
table(data, :cell_style => {:border_width => 0.5}, :column_widths => [270, 270], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Embalagem: #{@amostra.embalagem}", "Conteúdo: #{@amostra.conteudo}"] ]
table(data, :cell_style => {:border_width => 0.5}, :column_widths => [270, 270], :position => :center, :row_colors => ["FFFFFF"])

data = [ ["Amostragem: de responsabilidade do solicitante", "Lote: #{@amostra.lote}"] ]
table(data, :cell_style => {:border_width => 0.5}, :column_widths => [270, 270], :position => :center, :row_colors => ["FFFFFF"])

data = [ ["Data de fabricação: #{@amostra.data_fabricacao}", "Data de validade: #{@amostra.data_validade}"] ]
table(data, :cell_style => {:border_width => 0.5}, :column_widths => [270, 270], :position => :center, :row_colors => ["FFFFFF"])
data = [ ["Fabricante: #{@amostra.fabricante}", "CNPJ: #{@amostra.fabricante_CNPJ}"] ]
table(data, :cell_style => {:border_width => 0.5}, :column_widths => [270, 270], :position => :center, :row_colors => ["FFFFFF"])

data = [ ["Endereço: #{@amostra.fabricante_rua}", "Bairro: #{@amostra.fabricante_bairro}"] ]
table(data, :cell_style => {:border_width => 0.5}, :column_widths => [270, 270], :position => :center, :row_colors => ["FFFFFF"])

data = [ ["Cidade: #{@amostra.fabricante_cidade}", "UF: #{@amostra.fabricante_UF}", "CEP: #{@amostra.fabricante_CEP}"] ]
table(data, :cell_style => {:border_width => 0.5}, :column_widths => [180, 180, 180], :position => :center, :row_colors => ["FFFFFF"])

data = [ ["Telefone: #{@amostra.fabricante_telefone}","Entrada no laboratório: #{@amostra.data_entrada.strftime("%d/%m/%Y")}", "Entrega do certificado: #{@amostra.data_saida.strftime("%d/%m/%Y")}"] ]
table(data, :cell_style => {:border_width => 0.5}, :column_widths => [180, 180, 180], :position => :center, :row_colors => ["FFFFFF"])

if @amostra.descricao != ""
	data = [ ["Descrição: #{@amostra.descricao}"] ]
	table(data, :cell_style => {:border_width => 0.5}, :column_widths => [540], :position => :center, :row_colors => ["FFFFFF"])
end

#SOLICITANTE
move_down 7

table  [ ["<b>SOLICITANTE</b>"] ], :cell_style => { :inline_format => true, :align => :center, :border_width => 0.5}, :column_widths => [540], :position => :center, :row_colors => ["EEEEEE"]

data = [ ["Solicitante: #{@amostra.solicitante}", "Endereço: #{@amostra.solicitante_rua}"] ]
table(data, :cell_style => {:border_width => 0.5}, :column_widths => [270, 270], :position => :center, :row_colors => ["FFFFFF"])

data = [ ["Bairro: #{@amostra.solicitante_bairro}","Cidade: #{@amostra.solicitante_cidade}", "UF: #{@amostra.solicitante_UF}"] ]
table(data, :cell_style => {:border_width => 0.5}, :column_widths => [180, 180, 180], :position => :center, :row_colors => ["FFFFFF"])

data = [ ["CNPJ: #{@amostra.solicitante_CNPJ}","CEP: #{@amostra.solicitante_CEP}", "Telefone: #{@amostra.solicitante_telefone}"] ]
table(data, :cell_style => {:border_width => 0.5}, :column_widths => [180, 180, 180], :position => :center, :row_colors => ["FFFFFF"])

#CARACTERÍSTICAS
if @amostra.caracteristicas != ""
	move_down 7
	table  [ ["<b>CARACTERÍSTICAS ORGANOLÉPTICAS</b>"] ], :cell_style => { :inline_format => true, :align => :center,:border_width => 0.5 }, :column_widths => [540], :position => :center, :row_colors => ["EEEEEE"]
	data = [ ["#{@amostra.caracteristicas}"] ]
	table(data, :cell_style => {:border_width => 0.5}, :column_widths => [540], :position => :center, :row_colors => ["FFFFFF"])
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
		move_down 7
		tipoNovo = tipo.dup
		tipoNovo.gsub!("á", "Á")
		tipoNovo.gsub!("à", "À")
		tipoNovo.gsub!("ã", "Ã")
		tipoNovo.gsub!("â", "Â")
		tipoNovo.gsub!("é", "É")
		tipoNovo.gsub!("ê", "Ê")
		tipoNovo.gsub!("í", "Í")
		tipoNovo.gsub!("ó", "Ó")
		tipoNovo.gsub!("õ", "Õ")
		tipoNovo.gsub!("ô", "Ô")
		tipoNovo.gsub!("ú", "Ú")
		tipoNovo.gsub!("ç", "Ç")
		table  [ ["<b>RESULTADO DE #{tipoNovo.upcase}</b>"] ], :cell_style => { :inline_format => true, :align => :center, :border_width => 0.5 }, :column_widths => [540], :position => :center, :row_colors => ["EEEEEE"]

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

					if (resultado.valor_referencia_parametro == "" and resultado.conclusao == "")
						data = [ ["Parâmetro: #{resultado.parametro}","Resultado: #{resultado.resultado}"] ]
						table(data, :column_widths => [270,270], :position => :center, :row_colors => ["FFFFFF"], :cell_style => {:inline_format => true, :border_width => 0.5})
					end	

					if (resultado.valor_referencia_parametro != "" and resultado.conclusao == "")
						data = [ ["Parâmetro: #{resultado.parametro}\nValor de referência: #{resultado.valor_referencia_parametro}","Resultado: #{resultado.resultado}"] ]
						table(data, :column_widths => [270,270], :position => :center, :row_colors => ["FFFFFF"], :cell_style => {:inline_format => true, :border_width => 0.5})
						#data = [ ["Valor de referência: #{resultado.valor_referencia_parametro}"] ]
						#table(data, :column_widths => [540], :position => :center, :row_colors => ["FFFFFF"], :cell_style => { :border_width => 0.5})
					end

					if (resultado.valor_referencia_parametro == "" and resultado.conclusao != "")
						data = [ ["Parâmetro: #{resultado.parametro}\nConclusão: #{resultado.conclusao}","Resultado: #{resultado.resultado}"] ]
						table(data, :column_widths => [270,270], :position => :center, :row_colors => ["FFFFFF"], :cell_style => {:inline_format => true, :border_width => 0.5})
						#data = [ ["Conclusão: #{resultado.conclusao}"] ]
						#table(data, :column_widths => [540], :position => :center, :row_colors => ["FFFFFF"], :cell_style => { :border_width => 0.5})
					end

					if (resultado.valor_referencia_parametro != "" and resultado.conclusao != "")
						data = [ ["Parâmetro: #{resultado.parametro}\nValor de referência: #{resultado.valor_referencia_parametro}","Resultado: #{resultado.resultado}\nConclusão: #{resultado.conclusao}"] ]
						table(data, :column_widths => [270,270], :position => :center, :row_colors => ["FFFFFF"], :cell_style => {:inline_format => true, :border_width => 0.5, :borders => [:left, :right, :top]})
						#data = [ ["Valor de referência: #{resultado.valor_referencia_parametro}", "Conclusão: #{resultado.conclusao}"] ]
						#table(data, :column_widths => [270, 270], :position => :center, :row_colors => ["FFFFFF"], :cell_style => {:borders => [:bottom, :left, :right], :border_width => 0.5})
					end

				end
				end
			end
		end

		if tem_resultado == 1
		if metRef != "--"
			data = [ ["<b>Método:</b> #{metRef[0, metRef.index('--')]}\n<b>Referência:</b> #{metRef[metRef.index('--')+2, metRef.length]}"] ]
			table(data, :cell_style => {:border_width => 0.5, :borders => [:top, :left, :right, :bottom], :inline_format => true}, :column_widths => [540], :position => :center, :row_colors => ["FFFFFF"])

			tem_resultado = 0
		end
		end
	end

end


#OBSERVAÇÕES
move_down 20
if (cursor < 80)
	start_new_page
	move_down 20
end

if @amostra.observacoes == ""
	text  "Observação:<i> Resultado válido para a amostra analisada.</i>", :indent_paragraphs => 30, :inline_format => true
else

	text  "Observações:<i> Resultado válido para a amostra analisada.</i>", :indent_paragraphs => 30, :inline_format => true
	text "<i>#{@amostra.observacoes}</i>", :indent_paragraphs => 85, :inline_format => true
end


# ASSINATURA
move_down 30
text  "________________________________________", :size => 16, :align => :center
text  "#{@amostra.assinatura} - #{@amostra.assinatura_tipo_conselho} #{@amostra.assinatura_numero_conselho}", :size => 10, :align => :center
text  "Responsável Técnico", :size => 10, :align => :center

# NÚMERO DA PÁGINA
number_pages "Certificado #{@amostra.certificado}  -  Pág. <page> / <total>", { :start_count_at => 0, :page_filter => :all, :at => [400, pdf.bounds.bottom], :align => :center, :size => 9 }

#repeat :all do
	# LOGO
#	image "public/image/logo2.png", :height => 40, :width => 35, :at => [bounds.left+5, pdf.bounds.bottom-15]
	# RUBRICA
#	bounding_box([bounds.left, pdf.bounds.bottom-15], :width => 40, :height => 40) do
#		transparent(1) { stroke_bounds }
#	end
#end
