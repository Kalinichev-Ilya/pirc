module V1
  class Test < Grape::API
    version 'v1'

    desc 'test api endpoint'
    resources :api do
      get :test do
        { hello: :world }
      end
    end
  end
end
