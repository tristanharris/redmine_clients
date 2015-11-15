function buildFilterRow_autocomplete(tag, field, fieldId, values) {
  tag.append(
    '<input type="hidden" name="v['+field+'][]" id="values_'+fieldId+'" />' +
    '<input type="text" id="values_'+fieldId+'_text" class="value" data-tagid="values_'+fieldId+'"/>'
  );
  $('#values_'+fieldId).val(values[0]);
  $('#values_'+fieldId+'_text').val(values[1]);
  apply_autocomplete('values_'+fieldId+'_text');
}

function apply_autocomplete(text_id) {
  var input = $('input#'+text_id);
  var id_tag = $('input#'+input.data('tagid'));
  if (id_tag.attr('value') != '' && (input.attr('value') == undefined || input.attr('value') == '')) {
    $.getJSON('/clients/'+id_tag.attr('value'),
      function(data) {
        input.val(data['label']);
    });
  } else {
    input.val(input.attr('value'));
  }
  input.autocomplete({
    source: '/clients',
    minLength: 3,
    select: function( event, ui ) {
      $(this).val(ui.item.label);
      $('input#'+$(this).data('tagid')).val(ui.item.value);
      return false;
    }
  });
}
