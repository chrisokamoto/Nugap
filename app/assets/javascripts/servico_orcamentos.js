// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


var servico_orcamentoFieldsUI = {	
    init: function() {
        var validationSettingsOrcamento = {
            errorMessagePositionOrcamento : 'element'
        };
        

        $('#new-servico-orcamento-fields').validateOnBlur();

        $('#addButtonServico').on('click', function(e) {

            var isValidOrcamento = $('#new-servico-orcamento-fields').validate(false, validationSettingsOrcamento);
            if(!isValidOrcamento) {
                e.stopPropagation();

                return false;
            }

            formHandlerOrcamento.appendFieldsOrcamento();
            formHandlerOrcamento.hideFormOrcamento();
        });
    }
};

var i=0;

var formHandlerOrcamento = {
    // Public method for adding a new row to the table.
    appendFieldsOrcamento: function() {
        // Get a handle on all the input fields in the form and detach them from the DOM (we will attach them later).
        
        var inputFieldsOrcamento = $(cfgOrcamento.formId + ' ' + 'input');
        inputFieldsOrcamento.detach();
        var textFieldsOrcamento = $(cfgOrcamento.formId + ' ' + 'valor_unitario');
        textFieldsOrcamento.detach();

        var selectFieldsOrcamento = $(cfgOrcamento.formId + ' ' + 'select');
        selectFieldsOrcamento.detach();


        // Build the row and add it to the end of the table.
        rowBuilder.addRow(cfgOrcamento.getTBodySelector(), inputFieldsOrcamento, selectFieldsOrcamento, textFieldsOrcamento);

        // Add the "Remove" link to the last cell.
        rowBuilder.link.clone().appendTo($(' tr:last td:last '));

    },

    // Public method for hiding the data entry fields.
    hideFormOrcamento: function() {
        $(cfgOrcamento.formId).modal('hide');
    }
};

var cfgOrcamento = {
    formId: '#new-servico-orcamento-fields',
    tableId: '#servicosOrcamentos-table',
    inputFieldClassSelector: '.field',
    getTBodySelector: function() {
        return this.tableId + ' tbody';
    }
};

var rowBuilder = function() {
    // Private property that define the default <TR> element text.
    var rowOrcamento = $('<tr>', { class: 'fields' });

    // Public property that describes the "Remove" link.
    var linkOrcamento = $('<a>', {
        href: '#',
        onclick: 'remove_fields(this); return false;',
        title: 'Excluir'
    }).append("Excluir");

    // A private method for building a <TR> w/the required data.
    var buildRowOrcamento = function(fields, selectFields, textFields) {
        var newRowOrcamento = rowOrcamento.clone();

        $(selectFields).map(function() {
            $(this).removeAttr('class');
            var td =  $('<td/>').append($(this));            
            td.appendTo(newRowOrcamento);            
        });//.appendTo(newRow);
        $(fields).map(function() {
            $(this).removeAttr('class');
            var td =  $('<td/>').append($(this));
            td.appendTo(newRowOrcamento);            
        });//.appendTo(newRow);        
        $(textFields).map(function() {
            $(this).removeAttr('class');
            var td =  $('<td/>').append($(this));
            td.appendTo(newRowOrcamento);            
        });//.appendTo(newRow);     


        return newRowOrcamento;
    }

    // A public method for building a row and attaching it to the end of a <TBODY> element.
    var attachRowOrcamento = function(tableBody, fields, selectFields, textFields) {
        var rowOrcamento = buildRowOrcamento(fields, selectFields, textFields);
        $(rowOrcamento).appendTo($(tableBody));
    }

    // Only expose public methods/properties.
    return {
        addRowOrcamento: attachRow,
        linkOrcamento: link
    }
}();
