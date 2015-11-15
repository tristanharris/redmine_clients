require 'redmine'

require 'client_format'

module ClientsPlugin
  class Hooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(context={ })
      return javascript_include_tag 'plugin', :plugin => 'clients'
    end
  end
end

Query.operators_by_filter_type[:autocomplete] = [ "=", "!" ]

Redmine::Plugin.register :clients do
  name 'Clients plugin'
  author 'Tristan Harris'
  description 'Add a clients field type'
  version '0.0.1'
end
