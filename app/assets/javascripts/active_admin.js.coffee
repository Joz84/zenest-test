#= require active_admin/base
#= require activeadmin_addons/all


$("#select_massage_category_admin").on("change keyup", () ->
    $(this).val()
   console.log('test');
);


$(document).on 'ready page:load', ->
  $('[data-change]').on "change", ->
    $($(this).data('change')).toggle($(this).val() == 'show')


$('#attribute').select2().on('change', () ->
    $('#value').select2({data:data[$(this).val()]});
).trigger('change');
