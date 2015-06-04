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
        tipo_analise = tipo_analise.replace(/%/g, "%25");        
        tipo_analise = tipo_analise.replace(/#/g, "%23"); 
        tipo_analise = tipo_analise.replace(/\//g, "%2F");

        var parametro = $("#parametro_resultado_parametro").val();      
        if(parametro == "")    
          parametro = " "
        parametro = parametro.replace(/%/g, "%25");   
        parametro = parametro.replace(/#/g, "%23");     
        parametro = parametro.replace(/\//g, "%2F");

        var resultado = $("#parametro_resultado_resultado").val();      
        if(resultado == "")    
          resultado = " "  
        resultado = resultado.replace(/%/g, "%25"); 
        resultado = resultado.replace(/#/g, "%23"); 
        resultado = resultado.replace(/\//g, "%2F");      	     

        var conclusao = $("#parametro_resultado_conclusao").val();      
        if(conclusao == "")    
          conclusao = " " 
	     conclusao = conclusao.replace(/%/g, "%25"); 
       conclusao = conclusao.replace(/#/g, "%23"); 
       conclusao = conclusao.replace(/\//g, "%2F");      

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
