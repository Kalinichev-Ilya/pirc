# frozen_string_literal: true

module V1
  class Test < Grape::API
    desc 'test api endpoint'
    get '/test' do
      { hello: :world }
    end
  end
end
