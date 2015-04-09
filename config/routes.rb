Rails.application.routes.draw do
  devise_for :admins
  resources :players

  resources :trophies

  get 'game/start'
  get 'game/category_selection'
  get 'play/index'
  get 'play/display_spinner'
  get 'play/display_questions'
  get 'play/display_trophy_select'
  get 'play/display_new_game_page'
  get 'play/display_question_rating'
  get 'play/display_full_meter_choice'


  resources :play do
    collection do
      put 'true_answer'
      put 'false_answer'
      put 'get_trophy_category'
      put 'get_selected_player'
      put 'make_new_challenge'
      put 'get_next_challenge_question'
    end
  end

  resources :questions do
    resources :answers
  end

  resources :categories do
    resources :trophies
    resources :questions do
      resources :answers
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'play#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
