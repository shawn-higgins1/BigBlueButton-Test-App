// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready(function() {
    if($("#session_join_session").prop("checked")){
        $('#moderator_details').toggle();
    }

    $("#session_join_session").change(function(){
        $('#moderator_details').toggle();
    });
});



