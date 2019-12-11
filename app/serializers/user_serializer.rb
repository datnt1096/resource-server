class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :image_url

  def image_url
    "#{ENV['OAUTH_SERVER_URL']}#{object.image.url}"
  end
end
