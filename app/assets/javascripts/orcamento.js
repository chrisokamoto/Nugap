$(document).ready(function(){
    //inicializa wizard begin    
    $("#the_wizard").fadeIn("slow");
    $("#wizard").bwizard();       
    $('.previous').hide();
    $('.next').hide();    

    //inicializa wizard end    

    var form = $("#orcamento_form").serialize();

    $("#empresa").autocomplete({  
        source: function (request, response) {
            $.ajax({
                headers: {
                  'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url: '/get_empresas',
                type: "GET",
                dataType: 'json',
                data: { characters: request.term},
                success: function (data) {
                  if (data.length == 0){
                    //$('#erro_tecnico_nao_encontrado').show(250);
                  }else
                  {
                    //$('#erro_tecnico_nao_encontrado').hide(250);
                  }
                  response(data);
                },
                error: function (xhr, status) {
                  console.log(status);
                }
            });
        },
        autoFocus: true,
        minLength:1,
        select: function(event, ui){
            $("#empresa").val(ui.item.value);
            var empresa = $('INPUT#empresa').val();              
     
          $.get('/orcamentos/get_telefone_empresa/' + empresa , function(data){                          
            });         
        },

        change: function(event, ui) {
            if (!ui.item) {
                $("#empresa").val('');                
            }
        }
    });

});

//funções necessárias para se 'movimentar' na wizard
function wizard_next() {$('.next').click();};
function wizard_previous() {$('.previous').click();};


jQuery(function($) {  

    $("#servico_orcamento_produto").change(function(){         

      var produto = $("#servico_orcamento_produto").val();
      if(produto == null)    
        produto = ""

      var analise = $("#servico_orcamento_analise").val();      
      if(analise == null)    
        analise = ""          

       $.get('/orcamentos/get_analises/' + produto , function(data){               
           $("#servico_orcamento_analise").html(data);           
        })       

       if (analise != ""){          
          $.get('/orcamentos/get_parametros/' + produto + '/' + analise, function(data){               
             $("#servico_orcamento_parametro").html(data);
          })
        }


      return false;

    });


  $("#servico_orcamento_analise").change(function() {    

      var produto = $("#servico_orcamento_produto").val();      
      if(produto == null)    
        produto = ""

      var analise = $("#servico_orcamento_analise").val();      
      if(analise == null)    
        analise = ""

        var n = analise.search("%");
        if(n != -1)
          var analise = [analise.slice(0, n+1), "25", analise.slice(n+1)].join('');        
     
        $.get('/orcamentos/get_parametros/' + produto + '/' + analise, function(data){             
           $("#servico_orcamento_parametro").html(data);
        })

      return false;
    });

    $("#servico_orcamento_parametro").change(function() {         

      var produto = $("#servico_orcamento_produto").val();      
      if(produto == null)    
        produto = ""

      var analise = $("#servico_orcamento_analise").val();      
      if(analise == null)    
        analise = ""

      var n = analise.search("%");
      if(n != -1)
        var analise = [analise.slice(0, n+1), "25", analise.slice(n+1)].join('');

      var parametro = $("#servico_orcamento_parametro").val();      
      if(parametro == null)    
        parametro = ""

      var n = parametro.search("%");
      if(n != -1)
        var parametro = [parametro.slice(0, n+1), "25", parametro.slice(n+1)].join('');        
     
        $.get('/orcamentos/get_valor_unitario/' + produto + '/' + analise + '/' + parametro, function(data){          
           $("#servico_orcamento_valor_unitario").html(data).change();           
        })

        
      return false;
    });

    $("#servico_orcamento_valor_unitario").change(function() {            

       var valor_unitario = $("#servico_orcamento_valor_unitario").val();      
      if(valor_unitario == null)    
        valor_unitario = ""  

      var qtd_amostra = $("#servico_orcamento_qtd_amostra").val();      
      if(qtd_amostra == null)    
        qtd_amostra = ""  
     
      $.get('/orcamentos/get_valor_total/' + valor_unitario + '/' + qtd_amostra, function(data){
           $("#servico_orcamento_valor_total").html(data);
        })      

      return false; 
      
    });

    

  $("#servico_orcamento_qtd_amostra").on("input",function() {             

       var valor_unitario = $("#servico_orcamento_valor_unitario").val();      
      if(valor_unitario == null)    
        valor_unitario = ""  

      var qtd_amostra = $("#servico_orcamento_qtd_amostra").val();      
      if(qtd_amostra == null)    
        qtd_amostra = ""  
     
      $.get('/orcamentos/get_valor_total/' + valor_unitario + '/' + qtd_amostra, function(data){
           $("#servico_orcamento_valor_total").html(data);
        })      

      return false;
    });

  
$("#addButtonServico").on("click", function() {   
  var produto = $("#servico_orcamento_produto").val();
      if(produto == null)    
        produto = ""

      var analise = $("#servico_orcamento_analise").val();      
      if(analise == null)    
        analise = "" 
      var n = analise.search("%");
      if(n != -1)
        var analise = [analise.slice(0, n+1), "25", analise.slice(n+1)].join('');
      var parametro = $("#servico_orcamento_parametro").val();      
      if(parametro == null)    
        parametro = ""
      var n = parametro.search("%");
      if(n != -1)
        var parametro = [parametro.slice(0, n+1), "25", parametro.slice(n+1)].join('');
      var valor_unitario = $("#servico_orcamento_valor_unitario").val();      
      if(valor_unitario == null)    
        valor_unitario = ""  

      var qtd_amostra = $("#servico_orcamento_qtd_amostra").val();      
      if(qtd_amostra == null)    
        qtd_amostra = "" 
      var valor_total = $("#servico_orcamento_valor_total").val();      
      if(valor_total == null)    
        valor_total = ""
      var id_orcamento = $("#id_orcamento").val();      
      if(id_orcamento == null)    
        id_orcamento = ""
      var id_servico_orcamento = $("#servico_orcamento_id").val();      
      if(id_servico_orcamento == "")    
        id_servico_orcamento = "-1"
      
  $.get('/orcamentos/saveVirtualServicoOrcamento/' + produto + '/' + analise + '/' + parametro + '/' + valor_unitario + '/' + qtd_amostra + '/' + valor_total + '/' + id_orcamento + '/' + id_servico_orcamento, function(){
    addAll(true);    
    //location.reload(); 
  })

});


$("#orcamento_desconto").on("input",function() {      
  addAll(false); 

    return false;
});


});


if($("INPUT#num_orcamento").val() != "")
    document.getElementById("submit").disabled = false;
  else 
    document.getElementById("submit").disabled = true;

$("#num_orcamento").on("change",function() {            
  
  if($("INPUT#num_orcamento").val() != "")
    document.getElementById("submit").disabled = false;
  else 
    document.getElementById("submit").disabled = true;
       

  return false;
});



function addAll(has_to_save) {    
  var id_orcamento = $("#id_orcamento").val();      
      if(id_orcamento == null)    
        id_orcamento = ""

  var total_pagar = 0
  $.get('/orcamentos/get_total/' + id_orcamento + '/' + has_to_save , function(data){               
    total_pagar = data;       
    $('#total_bruto').val(total_pagar);    

    var desconto = $('INPUT#orcamento_desconto').val();      
      if(desconto == "")    
        desconto = "0"  
     
      $.get('/orcamentos/get_valor_desconto/' + total_pagar + '/' + desconto, function(data){            
           total_pagar = data;
           $.get('/orcamentos/get_valor_impostos/' + total_pagar , function(data){
            
          })
        })      
        
  }) 
      
}

function edit_servico_orcamento(servico_orcamento_id){  
  $.get('/orcamentos/set_servico/' + servico_orcamento_id , function(data){

  })
}

function delete_servico_orcamento(servico_orcamento_id){  
  $.get('/orcamentos/delete_servico/' + servico_orcamento_id , function(data){    
    
      })  
}