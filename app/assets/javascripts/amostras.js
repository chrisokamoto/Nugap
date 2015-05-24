$(window).load(function(){    
  var id_amostra = $("#id_amostra").val();
  var id_orcamento = $("#id_orcamento").val();   

  if(id_orcamento){      
      $('a[href^="#step2"]').click();   
    }

  if(id_amostra)
      $('a[href^="#step3"]').click();    

  if(id_amostra == "")    
    $('a[href^="#step1"]').click();
  
});

jQuery(function($) {  

  $("#addButtonResultado").on("click", function() {     
    var tipo_analise = $("#parametro_resultado_tipo").val();
        if(tipo_analise == null)    
          tipo_analise = ""

        var n = tipo_analise.search("%");
        if(n != -1)
          var tipo_analise = [tipo_analise.slice(0, n+1), "25", tipo_analise.slice(n+1)].join('');        

        var parametro = $("#parametro_resultado_parametro").val();      
        if(parametro == "")    
          parametro = " "
        var n = parametro.search("%");
        if(n != -1)
          var parametro = [parametro.slice(0, n+1), "25", parametro.slice(n+1)].join('');        

        var resultado = $("#parametro_resultado_resultado").val();      
        if(resultado == "")    
          resultado = " "  

        var conclusao = $("#parametro_resultado_conclusao").val();      
        if(conclusao == "")    
          conclusao = " " 

        var id_amostra = $("#id_amostra").val();      
        if(id_amostra == null)    
          id_amostra = ""

        var id_parametro_resultado = $("#parametro_resultado_id").val();      
        if(id_parametro_resultado == "")    
          id_parametro_resultado = "-1"
        
    $.get('/amostras/saveVirtualParametroResultado/' + tipo_analise + '/' + parametro + '/' + resultado + '/' + conclusao + '/' + id_amostra + '/' + id_parametro_resultado, function(){      
      location.reload();
    })

  });

});

function edit_parametro_resultado(parametro_resultado_id){  
  $.get('/amostras/set_resultado/' + parametro_resultado_id , function(data){

  })
}

function delete_parametro_resultado(parametro_resultado_id){  
  $.get('/amostras/delete_resultado/' + parametro_resultado_id , function(data){    
    
  })
}
