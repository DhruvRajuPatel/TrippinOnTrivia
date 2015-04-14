Rails.application.routes.draw do
  get 'questions/create_user_question'
  post "questions/create_user_question" => "questions#create_user_question", :as => :create_user_question

  resources :friendships
  devise_for :admins
  resources :players
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
      put 'achievement_message_recieved'
      put 'resign'
      put 'phone_google'
      put 'eliminate'
      put 'toggle_mute'
    end
  end



  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match 'users/:id' => 'admin#destroy', :via => :delete, :as => :admin_destroy_user
  resources :users

  root 'play#index'

end
