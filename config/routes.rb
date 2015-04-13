Rails.application.routes.draw do

  devise_for :admins
  resources :players
  resources :charges
  resources :trophies

  get 'play/index'
  get 'play/display_spinner'
  get 'play/display_questions'
  get 'play/display_trophy_select'
  get 'play/display_new_game_page'
  get 'play/display_question_rating'
  get 'play/display_full_meter_choice'
  get 'play/display_challenge_trophy_selection'

  get 'admin/dashboard'

  resources :play do
    collection do
      put 'true_answer'
      put 'false_answer'
      put 'get_trophy_category'
      put 'get_selected_player'
      put 'make_new_challenge'
      put 'continue_challenge'
      put 'end_current_challenge'
      put 'finish_question'
      put 'get_random_category'
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
  match 'users/:id' => 'admin#destroy', :via => :delete, :as => :admin_destroy_user
  resources :users

  root 'play#index'

end
