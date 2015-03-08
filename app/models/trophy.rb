class Trophy < ActiveRecord::Base
  belongs_to :category, dependent: :destroy
end
