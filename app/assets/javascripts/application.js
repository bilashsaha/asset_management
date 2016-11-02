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
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require jquery-ui

$(document).ready(function () {
    $("input#is_redeemed").click(function(e){
        var clicked_checkbox = $(this);
        var token_id = clicked_checkbox.attr("token_id")
        var is_checked = clicked_checkbox.prop('checked')
        $.ajax({
            url: '/tokens/' + token_id + '.json',
            type: 'PUT',
            data: {token: {is_redeemed: is_checked ? "1" : 0 }},
            success: function(response){
                clicked_checkbox.parent().html("<img src='/tick.png'>")
            },
            error: function(response) {
                alert("Something Bad Happened !!")
                clicked_checkbox.prop('checked',false);
            }
        })
    })

    $('.datepicker').datetimepicker({
        viewMode: 'years',
        format: 'YYYY-MM-DD'
    });

});