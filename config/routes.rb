Rails.application.routes.draw do
  scope(:module => :fat_free_crm_mingle) do
    resources :mingle
  end

  namespace :admin do
    resources :mingle, :only => :index do
      put :update, :on => :collection
    end
  end
end
