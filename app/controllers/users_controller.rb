class UsersController < ApplicationController
  def me
    authorization = Authorization.find_by token: params[:access_token]
    if authorization.present? && ((authorization.token_created_at.to_datetime + 7.days) > Time.now)
      user = authorization.user
      render_response(generate_json(user, serializer: UserSerializer).as_json, 200)
    else
      authorization.try(:update, token: nil, token_created_at: nil)
      render_response({}, 404)
    end
  end
end
