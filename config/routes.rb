Rails.application.routes.draw do
  scope format: "json" do
    post "me", to: "users#me"
  end
end
