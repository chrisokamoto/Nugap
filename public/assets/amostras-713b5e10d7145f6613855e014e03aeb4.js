function edit_parametro_resultado(a){$.get("/amostras/set_resultado/"+a,function(){})}function delete_parametro_resultado(a){$.get("/amostras/delete_resultado/"+a,function(){})}$(window).load(function(){var a=$("#id_amostra").val(),r=$("#id_orcamento").val();r&&$('a[href^="#step2"]').click(),a&&$('a[href^="#step3"]').click(),""==a&&$('a[href^="#step1"]').click()}),jQuery(function(a){a("#addButtonResultado").on("click",function(){var r=a("#parametro_resultado_tipo").val();null==r&&(r=""),r=r.replace(/%/g,"%25");var e=a("#parametro_resultado_parametro").val();""==e&&(e=" "),e=e.replace(/%/g,"%25");var t=a("#parametro_resultado_resultado").val();""==t&&(t=" "),t=t.replace(/%/g,"%25");var o=a("#parametro_resultado_conclusao").val();""==o&&(o=" "),o=o.replace(/%/g,"%25");var l=a("#id_amostra").val();null==l&&(l="");var s=a("#parametro_resultado_id").val();""==s&&(s="-1"),a.get("/amostras/saveVirtualParametroResultado/"+r+"/"+e+"/"+t+"/"+o+"/"+l+"/"+s,function(){location.reload()})})});