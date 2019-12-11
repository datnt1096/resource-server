class AppSerializer < ActiveModel::Serializer
  attributes :id, :name, :home_page, :description, :callback_url
end
