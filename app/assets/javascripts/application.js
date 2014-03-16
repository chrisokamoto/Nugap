// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.PP
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require autonumeric
//= require bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require turbolinks
//= require wice_grid
//= require_tree .


function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
}
 
function add_fields(link, association, content) {	
    var new_id = new Date().getTime();    
    var regex = new RegExp("new_" + association, "g");    
    $(link).parent().after(content.replace(regex, new_id));    
    $('#new-parametro-resultado-fields').modal('show');
}

function remove_fields_servico(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
}
 
function add_fields_servico(link, association, content) {	
    var new_id = new Date().getTime();    
    var regex = new RegExp("new_" + association, "g");    
    $(link).parent().after(content.replace(regex, new_id));    
    $('#new-servico-orcamento-fields').modal('show');
}










