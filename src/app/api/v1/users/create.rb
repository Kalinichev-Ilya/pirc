module V1
  module Users
    class Create
      version :v1 do
        # POST /api/v1/users
        desc 'Create new user account',
             named: 'create',
             success: { code: 201, model: API::V1::Entities::User}
        params do
          requires :username, type: String, allow_blanck: false
          requires :password_digest, type: String, allow_blanck: false
        end
        post do
          attributes = declared(params).to_h
          present ::User.create!(attributes).reload,
                  with: API::V1::Entities::User
        end
      end
    end
  end
end
