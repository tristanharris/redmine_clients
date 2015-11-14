require 'redmine'

require 'client_format'

Redmine::Plugin.register :clients do
  name 'Clients plugin'
  author 'Tristan Harris'
  description 'Add a clients field type'
  version '0.0.1'
end
