::Refinery::Application.routes.draw do
  get '/fees/create', :to => 'fees#create'

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :fees do
      collection do
        get :pair
        get :paired
        get :unpaired
      end
    end
  end
end
