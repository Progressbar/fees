::Refinery::Application.routes.draw do
  get '/fees/create', :to => 'fees#create'

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :fees, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end
