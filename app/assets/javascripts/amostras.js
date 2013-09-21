// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


var parametro_resultadoFieldsUI = {	
    init: function() {
        var validationSettings = {
            errorMessagePosition : 'element'
        };
        

        $('#new-parametro-resultado-fields').validateOnBlur();

        $('#addButton').on('click', function(e) {

            var isValid = $('#new-parametro-resultado-fields').validate(false, validationSettings);
            if(!isValid) {
                e.stopPropagation();

                return false;
            }

            formHandler.appendFields();
            formHandler.hideForm();
        });
    }
};

var i=0;

var formHandler = {
    // Public method for adding a new row to the table.
    appendFields: function() {
        // Get a handle on all the input fields in the form and detach them from the DOM (we will attach them later).

        var inputFields = $(cfg.formId + ' ' + cfg.inputFieldClassSelector);
        inputFields.detach();

        var selectFields = $(cfg.formId + ' ' + 'select');
        selectFields.detach();

        // Build the row and add it to the end of the table.
        rowBuilder.addRow(cfg.getTBodySelector(), inputFields, selectFields);

        // Add the "Remove" link to the last cell.
        rowBuilder.link.clone().appendTo($(' tr:last td:last '));

    },

    // Public method for hiding the data entry fields.
    hideForm: function() {
        $(cfg.formId).modal('hide');
    }
};

var cfg = {
    formId: '#new-parametro-resultado-fields',
    tableId: '#parametrosResultados-table',
    inputFieldClassSelector: '.field',
    getTBodySelector: function() {
        return this.tableId + ' tbody';
    }
};

var rowBuilder = function() {
    // Private property that define the default <TR> element text.
    var row = $('<tr>', { class: 'fields' });

    // Public property that describes the "Remove" link.
    var link = $('<a>', {
        href: '#',
        onclick: 'remove_fields(this); return false;',
        title: 'Excluir'
    }).append("Excluir");

    // A private method for building a <TR> w/the required data.
    var buildRow = function(fields, selectFields) {
        var newRow = row.clone();

        $(selectFields).map(function() {
            $(this).removeAttr('class');
            var td =  $('<td/>').append($(this));
            td.appendTo(newRow);            
        });//.appendTo(newRow);
        $(fields).map(function() {
            $(this).removeAttr('class');
            var td =  $('<td/>').append($(this));
            td.appendTo(newRow);            
        });//.appendTo(newRow);


        return newRow;
    }

    // A public method for building a row and attaching it to the end of a <TBODY> element.
    var attachRow = function(tableBody, fields, selectFields) {
        var row = buildRow(fields, selectFields);
        $(row).appendTo($(tableBody));
    }

    // Only expose public methods/properties.
    return {
        addRow: attachRow,
        link: link
    }
}();