# frozen_string_literal: true

class Root < Grape::API
  include V1::Errors
  include V1::Helpers::ErrorHandler

  prefix :api
  version :v1, using: :path

  format :json

  mount V1::Base

  add_swagger_documentation(
    add_version:             true,
    doc_version:             '0.0.1',
    hide_documentation_path: true,
    info:                    {
      title: 'pIRC API V1'
    }
  )

  route :any, '*path' do
    error!(Errors::NotFoundError.new, 404)
  end
end
