Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :multibanco_providers, :except => [:show, :destroy] do
      put :toggle_activation, :on => :member
    end
  end

  namespace :api, defaults: { format: 'json' } do
    resources :payments do
      post 'capture_mb_payment', on: :collection
    end
  end
end
