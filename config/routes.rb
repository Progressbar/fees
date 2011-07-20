::Refinery::Application.routes.draw do
  resources :fees, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :fees, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end
