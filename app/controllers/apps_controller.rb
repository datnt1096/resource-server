class AppsController < ApplicationController
  def show
  	app = OauthApp.find_by token: params[:access_token]
  	if app.present? && ((app.token_created_at.to_datetime + 7.days) > Time.now)
  	  render_response(generate_json(app, serializer: AppSerializer).as_json, 200)
  	else
      app.try(:update, token: nil, token_created_at: nil)
      render_response({}, 404)
  	end
  end

  def update
  	app = OauthApp.find_by token: params[:access_token]
  	if app.present? && ((app.token_created_at.to_datetime + 7.days) > Time.now) && app.update(update_params)
  	  render_response({success: "Cập nhật thông tin thành công"}, 200)
  	else
      app.try(:update, token: nil, token_created_at: nil)
      render_response({}, 404)
  	end
  end

  private

  def update_params
  	params.require(:app).permit :name, :home_page, :description, :callback_url
  end
end
