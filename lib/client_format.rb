module Redmine
  module FieldFormat
    class ClientFormat < Base
      add 'client'
      self.multiple_supported = false

      def label
        'client.label'
      end

      def cast_single_value(custom_field, value, customized=nil)
        return '' if value.blank?
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
          view.javascript_tag("apply_autocomplete('#{text_id}');")
      end

      def bulk_edit_tag(view, tag_id, tag_name, custom_field, objects, value, options={})
        text_id = tag_id + '_text'
        text = cast_single_value(custom_field, value)
        view.hidden_field_tag(tag_name, value, options.merge(:id => tag_id)) +
          view.text_field_tag(nil, text, options.merge(:id => text_id, :data => {tagid: tag_id})) +
          bulk_clear_tag(view, tag_id, tag_name, custom_field, value) +
          view.javascript_tag("apply_autocomplete('#{text_id}');")
      end

      def query_filter_options(custom_field, query)
        {:type => :autocomplete}
      end

    end
  end
end

