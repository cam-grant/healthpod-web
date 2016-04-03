// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function sessionTimeout() {
  // setTimeout(function() { home(); }, 5000);
}

function initPage() {

  $('[data-option-group]').each(function(i, group) {
    var group = $(group);
    var field = $('#' + group.attr('data-option-group'));
    var callback = group.attr('data-callback');
    var options = group.find('.option');

    options.each(function(i, option) {
      var option = $(option);
      option.click(function() {
        options.each(function(j, o) { $(o).removeClass('selected'); })
        option.addClass('selected');
        var val = option.attr('data-value');
        if (field) field.val(val);
        if (callback) {
          eval(callback + '("' + val + '")');
        }
      });
    });
  });

  $(".checkbox-options").each(function(i, group) {
    var group = $(group);
    var field = $('#' + group.attr('data-field'));
    var options = group.find('.option');
    var callback = group.attr('data-callback');

    options.each(function(i, option) {
      var option = $(option);
      option.click(function() {
        if (option.hasClass('selected')) { option.removeClass('selected'); }
        else { option.addClass('selected') }

        // Concatenate all selected values
        var values = new Array();
        options.each(function(i2, option2) {
          var option2 = $(option2);
          if (option2.hasClass('selected')) {
            values.push(option2.attr('data-value'));
          }
        });
        if (field) {
          field.val(values);
        }
      });
    });
  });
  
}
