class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :image_url

  def image_url
    object.image_url
  end
end
