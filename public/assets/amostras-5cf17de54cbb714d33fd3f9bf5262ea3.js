function edit_parametro_resultado(a){$.get("/amostras/set_resultado/"+a,function(){})}function delete_parametro_resultado(a){$.get("/amostras/delete_resultado/"+a,function(){})}$(window).load(function(){var a=$("#id_amostra").val(),r=$("#id_orcamento").val();r&&$('a[href^="#step2"]').click(),a&&$('a[href^="#step3"]').click(),""==a&&$('a[href^="#step1"]').click()}),jQuery(function(a){a("#addButtonResultado").on("click",function(){var r=a("#parametro_resultado_tipo").val();null==r&&(r="");var t=r.search("%");if(-1!=t)var r=[r.slice(0,t+1),"25",r.slice(t+1)].join("");var e=a("#parametro_resultado_parametro").val();""==e&&(e=" ");var t=e.search("%");if(-1!=t)var e=[e.slice(0,t+1),"25",e.slice(t+1)].join("");var o=a("#parametro_resultado_resultado").val();""==o&&(o=" ");var l=a("#parametro_resultado_conclusao").val();""==l&&(l=" ");var s=a("#id_amostra").val();null==s&&(s="");var i=a("#parametro_resultado_id").val();""==i&&(i="-1"),a.get("/amostras/saveVirtualParametroResultado/"+r+"/"+e+"/"+o+"/"+l+"/"+s+"/"+i,function(){location.reload()})})});