class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  serialization_scope nil

  private

  def render_response data, status
    render json: data, status: status
  end

  def generate_json objects, options = {}
    ActiveModelSerializers::SerializableResource.new objects, options
  end
end
