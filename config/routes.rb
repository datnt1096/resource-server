Rails.application.routes.draw do
  scope format: "json" do
    post "me", to: "users#me"
    get "buy", to: "users#buy"
    get "apps", to: "apps#show"
    post "apps", to: "apps#update"
  end
end
