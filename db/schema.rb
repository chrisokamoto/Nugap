# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130922191655) do

  create_table "amostras", force: true do |t|
    t.date     "data_fabricacao"
    t.date     "data_validade"
    t.string   "lote"
    t.float    "conteudo"
    t.text     "descricao"
    t.text     "caracteristicas"
    t.string   "solicitante"
    t.string   "fabricante"
    t.string   "produto"
    t.string   "embalagem"
    t.string   "assinatura"
    t.string   "unidade"
    t.string   "status"
    t.string   "certificado"
    t.string   "marca"
    t.date     "data_entrada"
    t.date     "data_saida"
    t.string   "observacoes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "analises", force: true do |t|
    t.string   "tipo"
    t.integer  "amostra_id"
    t.string   "numero"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assinaturas", force: true do |t|
    t.string   "nome"
    t.string   "tipo_conselho"
    t.string   "numero_conselho"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "embalagems", force: true do |t|
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "empresas", force: true do |t|
    t.string   "nome"
    t.string   "logradouro"
    t.string   "rua"
    t.integer  "numero"
    t.string   "bairro"
    t.string   "cidade"
    t.string   "UF"
    t.string   "CEP"
    t.string   "CNPJ"
    t.string   "telefone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "observacaos", force: true do |t|
    t.string   "texto"
    t.integer  "amostra_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parametro_resultados", force: true do |t|
    t.string   "parametro"
    t.string   "resultado"
    t.string   "tipo"
    t.integer  "amostra_id"
    t.string   "conclusao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parametros", force: true do |t|
    t.string   "nome"
    t.string   "referencia"
    t.string   "metodo"
    t.string   "valor_referencia"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "produtos", force: true do |t|
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resultados", force: true do |t|
    t.string   "valor"
    t.integer  "parametro_id"
    t.string   "amostra_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_analises", force: true do |t|
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unidades", force: true do |t|
    t.string   "tipo"
    t.integer  "amostra_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", force: true do |t|
    t.string   "login"
    t.string   "nome"
    t.string   "sobrenome"
    t.string   "senha_hash"
    t.string   "senha_salt"
    t.string   "permissao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
