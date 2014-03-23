require 'spec_helper'

describe LoginController do

	let(:usuario) {mock_model(Usuario)}

	describe 'Realizar login' do

		it 'Campo usuário em branco' do
			post :login, {login: '', senha: ''}
			response.should redirect_to(login_path)
			flash[:error].should eql("Preencha o usuário.")
		end

		it 'Campo senha em branco' do
			post :login, {login: 'nome', senha: ''}
			response.should redirect_to(login_path)
			flash[:error].should eql("Preencha a senha.")
		end

		#it 'Login sucesso' do
		#	post :login, {nome: 'nugap', senha: 'nugap'}
		#	response.should redirect_to(amostras_path)
		#	expect(flash).to be_empty
		#end

	end


end
