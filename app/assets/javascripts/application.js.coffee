#= require jquery
#= require jquery_ujs
#= require_tree .
#= require bootstrap

$ ->
 $('#reproduction_reproduction_simbol').change () ->
   if ($('#reproduction_reproduction_simbol').val() == '▲ Inseminación')
     $('#reproduction_bull').attr('disabled', false)
   else
     $('#reproduction_bull').attr('disabled', true)
 $( "#dp3" ).datepicker({format: 'dd/mm/yyyy', changeMonth: true, changeYear: true, weekStart: 1});
 $( "#dp4" ).datepicker({format: 'dd/mm/yyyy', changeMonth: true, changeYear: true, weekStart: 1});

