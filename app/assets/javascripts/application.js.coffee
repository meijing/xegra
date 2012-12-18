#= require jquery
#= require jquery_ujs
#= require_tree .
$ ->
 $('#reproduction_reproduction_simbol').change () ->
   if ($('#reproduction_reproduction_simbol').val() == '♂ Pariu macho')
     $('#reproduction_bull').attr('disabled', false)
     $('#reproduction_date').attr('disabled', false)
   else
     $('#reproduction_bull').attr('disabled', true)
     $('#reproduction_date').attr('disabled', true)
 $( "#dp3" ).datepicker({format: 'dd/mm/yyyy', changeMonth: true, changeYear: true});

 
