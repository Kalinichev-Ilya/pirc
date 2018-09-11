module V1
  module Entities
    class Base < Grape::Entity
      format_with :string do |attribute|
        attribute.to_s
      end

    end
  end
end
