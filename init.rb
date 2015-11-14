require 'redmine'

module Redmine
  module FieldFormat
    class ClientFormat < Base
      add 'client'
      self.multiple_supported = false

      def label
        'client.label'
      end

      def cast_single_value(custom_field, value, customized=nil)
        Client.find(value).name || ::I18n.t('client.unknown')
      end

      def validate_single_value(custom_field, value, customized=nil)
        errs = super
        errs << ::I18n.t('client.unknown') unless Client.find(value)
        errs
      end

      def edit_tag(view, tag_id, tag_name, custom_value, options={})
        text_id = tag_id + '_text'
        text = cast_custom_value(custom_value)
        view.hidden_field_tag(tag_name, custom_value.value, options.merge(:id => tag_id)) +
        view.text_field_tag(nil, text, options.merge(:id => text_id, :data => {tagid: tag_id})) +
          "<script>$('input##{h(text_id)}').autocomplete({
      source: '/clients',
      minLength: 3,
      select: function( event, ui ) {
      console.log(this, event, ui);
        $(this).val(ui.item.label);
        $('input#'+$(this).data('tagid')).val(ui.item.value);
        console.log( ui.item ?
          'Selected: ' + ui.item.value + ' aka ' + ui.item.id :
          'Nothing selected, input was ' + this.value );
        return false;
      }
    });</script>".html_safe
      end

    end
  end
end

Redmine::Plugin.register :clients do
  name 'Clients plugin'
  author 'Tristan Harris'
  description 'Add a clients field type'
  version '0.0.1'
end
