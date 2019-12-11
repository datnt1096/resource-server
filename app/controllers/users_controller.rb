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

  def buy
    authorization = Authorization.find_by token: params[:access_token]
    if authorization.present? && ((authorization.token_created_at.to_datetime + 7.days) > Time.now)
      user = authorization.user
      owner = authorization.oauth_app.user
      if user.wallet < params[:amount]
        render_response({error: "Bạn không có đủ tiền trong tài khoản, vui lòng nạp thêm tiền để thực hiện giao dịch"}, 404)
      else
        subamount = user.wallet - params[:amount]
        sumamount = owner.wallet + params[:amount]
        user.update wallet: subamount
        owner.update wallet: sumamount
        render_response({success: "Bạn đã mua bài hát thành công."}, 200)
      end
    else
      authorization.try(:update, token: nil, token_created_at: nil)
      render_response({error: "Access token không đúng hoặc hết hạn"}, 404)
    end
  end
end
