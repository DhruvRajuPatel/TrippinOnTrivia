class Answer < ActiveRecord::Base
  belongs_to :question , dependent: :destroy

  def to_s
    "#{title}"
  end
end
