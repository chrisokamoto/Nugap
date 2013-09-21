json.array!(@assinaturas) do |assinatura|
  json.extract! assinatura, :nome, :crfmg
  json.url assinatura_url(assinatura, format: :json)
end
