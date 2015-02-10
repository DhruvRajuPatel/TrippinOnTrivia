class Answer < ActiveRecord::Base
  belongs_to :questions , dependent: :destroy
end
