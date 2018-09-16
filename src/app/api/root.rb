# frozen_string_literal: true

class Root < Grape::API
  include API::V1::Errors
  include API::V1::Helpers::ErrorHandler

  prefix :api

  format :json

  mount API::V1::Root

  add_swagger_documentation(
    add_version:             true,
    doc_version:             '0.0.1',
    hide_documentation_path: true,
    info:                    {
      title: 'pIRC API V1'
    }
  )

  route :any, '*path' do
    error!(NotFound, 404)
  end
end
