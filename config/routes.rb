Rails.application.routes.draw do
  get 'questions/create_user_question'
  post "questions/create_user_question" => "questions#create_user_question", :as => :create_user_question

  resources :friendships
  devise_for :admins
  resources :charges
  resources :trophies

  resources :questions do
    resources :answers
  end

  resources :categories do
    resources :trophies
    resources :questions do
      resources :answers
    end
  end

  get 'play/index'
  get 'play/display_spinner'
  get 'play/display_questions'
  get 'play/display_trophy_select'
  get 'play/display_new_game_page'
  get 'play/display_question_rating'
  get 'play/display_full_meter_choice'
  get 'play/display_challenge_trophy_selection'
  get 'play/display_friends'

  get 'admin/dashboard'

  resources :play do
    collection do
      put 'get_selected_player'
      put 'get_random_category'
      put 'achievement_message_received'
      put 'use_power_up'
      put 'toggle_mute'
      put 'play_friend'
    end
  end

  resources :challenges do
    collection do
      put 'continue_challenge'
      put 'end_current_challenge'
      put 'set_challenge_trophy_by_id'
    end
  end

  resources :players do
    collection do
      put 'resign_current_player'
      put 'handle_correct_response'
      put 'handle_incorrect_response'
      put 'reset_question_properties'
      put 'set_category_by_id'
    end
  end


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match 'users/:id' => 'admin#destroy', :via => :delete, :as => :admin_destroy_user
  resources :users

  root 'play#index'

end
