FatFreeCRM::Application.routes.draw do
  namespace :admin do
    resources :mingle, :only => :index do
      put :update, :on => :collection
    end
  end
end
