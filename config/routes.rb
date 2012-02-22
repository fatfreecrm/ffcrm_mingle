Rails.application.routes.draw do
  resources :mingle

  namespace :admin do
    resources :mingle, :only => :index do
      put :update, :on => :collection
    end
  end
end
