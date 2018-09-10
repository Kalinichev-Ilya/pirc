module V1
  class Base < Grape::API
    version :v1

    mount V1::Test
  end
end
