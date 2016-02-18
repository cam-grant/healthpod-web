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

$(document).ready(function () {
  $('[data-option-group]').each(function(i, group) {
    group = $(group);
    field = $('#' + group.attr('data-option-group'));
    options = group.find('.option');
    callback = group.attr('data-callback');

    options.each(function(i, option) {
      option = $(option);
      option.click(function() {
        options.each(function(i, o) { $(o).removeClass('selected'); })
        option.addClass('selected');
        val = option.attr('data-value');
        if (field) field.val(val);
        if (callback) {
          eval(callback + '("' + val + '")');
        }
      });
    });
  });
});
