# Padroniza arquivo edição
sed -i -e "s/<h1>Editing /<legend>Editar /g" -e "s/<\/h1>/<\/legend>/g" -e "s/Show/Detalhes/g" -e "s/Back/Voltar/g" -e "s/ %> |/, :class => 'btn btn-info' %>/g" -e "s/_path %>/_path, :class => 'btn btn-info' %>/g" $1/edit.html.erb
echo "Arquivo "$1/edit.html.erb" modificado com sucesso!\n"

# Padroniza arquivo assinatura
sed -i -e "s/f.submit/f.submit \"Salvar\"/g" $1/_form.html.erb
echo "Arquivo "$1/_form.html.erb" modificado com sucesso!\n"

# Padroniza index
#sed -e "s/<h1>Listing .*<\/h1>/<legend>"$1" cadastradas<\/legend>/g" -e "s/Edit/Editar/g" -e"s/Show/Detalhes/g" -e"s/Destroy/Excluir/g" -e"s/<table>/<table cellpadding=\"0\" cellspacing=\"0\" border=\"1\" class=\"table table-striped table-bordered\" id=\"example\" width=\"70%\">/g" -e"s/link_to 'New/link_to 'Nova/g" -e"s/ } %><\/td>/ }, :class => 'btn btn-mini btn-danger' %><\/td>/g" -e"s/ %><\/td>/, :class => 'btn btn-mini btn-info' %><\/td>/g" -e"s/<th>/<th><center>/g" -e"s/<td>/<td><center>/g" -e"s/<\/th>/<\/center><\/th>/g" -e"s/<\/td>/<\/center><\/td>/g" -e"s/_path %>/_path, :class => 'btn btn-info'%>/g" $1/index.html.erb
sed -i -e "s/<h1>Listing .*<\/h1>/<legend>"$1" cadastradas<\/legend>/g" -e "s/Edit/Editar/g" -e"s/Show/Detalhes/g" -e"s/Destroy/Excluir/g" -e"s/<table>/<table cellpadding=\"0\" cellspacing=\"0\" border=\"1\" class=\"table table-striped table-bordered\" id=\"example\" width=\"70%\">/g" -e"s/link_to 'New/link_to 'Nova/g" -e"s/<th>/<th><center>/g" -e"s/<td>/<td><center>/g" -e"s/<\/th>/<\/center><\/th>/g" -e"s/<\/td>/<\/center><\/td>/g" -e"s/_path %>/_path, :class => 'btn btn-info'%>/g" $1/index.html.erb
echo "Arquivo "$1/index.html.erb" modificado com sucesso!\n"

# Padroniza arquivo new
sed -i -e "s/<h1>New /<legend>Nova /g" -e "s/<\/h1>/<\/legend>/g" -e "s/Back/Voltar/g" -e "s/_path %>/_path, :class => 'btn btn-info' %>/g" $1/new.html.erb
echo "Arquivo "$1/new.html.erb" modificado com sucesso!\n"

# Padroniza arquivo show
sed -i -e "s/Back/Voltar/g" -e "s/Edit/Editar/g" -e "s/_path %>/_path, :class => 'btn btn-info' %>/g" -e "s/ %> |/, :class => 'btn btn-info' %>/g" -e "s/_path %>/_path, :class => 'btn btn-info' %>/g" $1/show.html.erb
echo "Arquivo "$1/show.html.erb" modificado com sucesso!\n"
