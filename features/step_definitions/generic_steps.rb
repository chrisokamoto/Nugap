Dado(/^que eu estou logado com o usuário "(.*?)"$/) do |user|
  u = Usuario.create(nome:user, senha:'senha-teste')
  l = Local.create(nome: "Local 1")
  UsuarioLocal.create(usuario: u, local: l)
  
  visit login_path
  fill_in(:nome, with:user)
  fill_in(:senha, with:'senha-teste')
  click_button(:Entrar)
  g = Grupo.create(nome:"cucumber-grupo-para-testes")
  UsuarioGrupo.create(usuario: u, grupo: g)
  page.should have_content('Local 1')
  steps %{
    Quando clico no link "Local 1"
  }
  page.should have_content('LOCAL 1')
end


Dado(/^que estou logado no local "(.*?)" com o usuario "(.*?)"$/) do |local, user|
  UsuarioLocal.create(usuario: Usuario.where(nome:"#{user}").take, local: Local.where(nome:"#{local}").take)
  visit login_local_path
  click_link("#{local}")
end

Dado(/^que eu tenho permissão em "(.+)" para "(.+)"$/) do |controlador, permissoes|
  permissoes.split(" e ").each do |permissao|
    unless permissao.nil?
      tipo = "read" if permissao == "visualização"
      tipo = "write" if permissao == "escrita"
      p = Permissao.create(descricao: "", controlador: controlador, tipo: tipo)
      GrupoPermissao.create(
        grupo: Grupo.where(nome: "cucumber-grupo-para-testes").take,
        permissao: p
      )
    end
  end
end

Dado (/^que eu estou em "(.+)"$/) do |page_name|
  visit path_to(page_name)
end

Dado(/^que existe um registro de smcs, com codigo "(.*?)" e descrição "(.*?)", cadastrado$/) do |codigo, descricao|
  SmcsComponente.create(codigo:"#{codigo}", descricao:"#{descricao}")
end

#--------------------------------------------

Quando(/^clico no botão "(.+)"$/) do |button|
	click_button(button)
end

Quando(/^clico no link "(.+)"$/) do |link|
	click_link(link)
end

Quando(/^preencho o campo "(.+)" com "(.*?)"$/) do |field, value|
  fill_in(field.gsub(' ', '_'), with: value)
end

Quando(/^preencho o campo numérico "(.+)" com (\d+)$/) do |field, value|
  fill_in(field.gsub(' ', '_'), with: value)
end

Quando(/^seleciono "(.+)" do campo "(.+)"$/) do |value, field|
  select(value, from: field)
end

def fill_autocomplete(field, options = {})
  fill_in field, with: options[:with]

  page.execute_script %Q{ $('##{field}').trigger('focus') }
  page.execute_script %Q{ $('##{field}').trigger('keydown') }
  selector = %Q{ul.ui-autocomplete li.ui-menu-item a:contains("#{options[:select]}")}

  page.should have_selector('ul.ui-autocomplete li.ui-menu-item a')
  page.execute_script %Q{ $('#{selector}').trigger('mouseenter').click() }
end


Quando(/^clico no icone de filtro$/) do
  page.find(:xpath, "//div[@title='Mostrar o filtro']").click
end

Quando /^preencho o filtro "(.+)" com "(.*?)"$/ do |field, value|
  fill_in("grid_f_#{field.downcase.gsub(' ', '_')}", with: value)
end

Quando(/^clico no botão de pesquisar$/) do
  find_by_id("grid_submit_grid_icon").click
end

Quando(/^confirmo a ação$/) do
  page.driver.browser.switch_to.alert.accept
end
#--------------------------------------------

Então (/^devo ver "(.+)"$/) do |text|
  page.should have_content(text)
end

Então /^devo ver \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  page.should have_content(regexp)
end


Então (/^não devo ver "(.+)"$/) do |text|
  page.should_not have_content(text)
end

Então /^não devo ver \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  page.should_not have_content(regexp)
end

Então /^o campo "(.+)" deve conter "(.+)"$/ do |field, value|
  find_field(field).value.should =~ /#{value}/
end

Então /^o campo "(.+)" deve não conter "(.+)"$/ do |field, value|
  find_field(field).value.should_not =~ /#{value}/
end

Então /^devo estar na página "(.+)"$/ do |page_name|
  expect(path_to(page_name)).to eql(current_path)
end

Então(/^a página deve mostrar a mensagem "(.+)"$/) do |text|
  page.has_css?("p.notice", text: text, visible: true)
end

Então(/^deve aparecer uma janela de confirmação com a mensagem "(.*?)"$/) do |mensagem|
  expect(page.driver.browser.switch_to.alert.text).to eql(mensagem)
end


Então(/^o campo de filtros é mostrado$/) do
  expect(page.find_by_id("grid_filter_row")).to be_true
end

Então(/^vejo o filtro de "(.*?)"$/) do |campo|
  campo = campo.gsub(' ','_').downcase
  campo << "s_nome" if campo =="modelo"
  expect(page.find_by_id("grid_f_#{campo}")).to be_true
end

Então(/^não vejo o filtro de "(.*?)"$/) do |campo|
  expect(page.has_field?("grid_f_#{campo.gsub(' ','_').downcase}")).to be_false
end

Então(/^devo ver a mensagem "(.*?)"$/) do |msg|
  steps %{
    Então devo ver "#{msg}"
  }
end

Então(/^devo ver a mensagem de erro: "(.*?)"$/) do |msg_erro|
  steps %{
    E devo ver "#{msg_erro}"
  }
end