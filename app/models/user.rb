class User < ActiveRecord::Base
  attr_accessor :avatar
  has_attached_file :avatar, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  LEVEL_UP_STATIC_THRESHOLD = 3
  LEVEL_UP_DYNAMIC_THRESHOLD = 2
  CATEGORY_ACHIEVEMENT_THRESHOLD = 3

  has_many :players, foreign_key: "uid"
  has_one :active_player, class_name: "Player", foreign_key: "active_player_id"
  has_and_belongs_to_many :achievements, foreign_key: "uid"
  has_one :aquatic_counter, class_name: "CategoryCorrectCounter", foreign_key: "aquatic_counter_id"
  has_one :memes_counter, class_name: "CategoryCorrectCounter", foreign_key: "memes_counter_id"
  has_one :basketball_counter, class_name: "CategoryCorrectCounter", foreign_key: "basketball_counter_id"
  has_one :literature_counter, class_name: "CategoryCorrectCounter", foreign_key: "literature_counter_id"
  has_one :music_counter, class_name: "CategoryCorrectCounter", foreign_key: "music_counter_id"
  has_one :cs_counter, class_name: "CategoryCorrectCounter", foreign_key: "cs_counter_id"
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  before_create :build_counters

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  MAX_LEVEL = 30.0


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.level = 1
      user.total_correct = 0
      user.avatar = auth.info.image

      unless user
        user = User.create(
            email: data['email'],
            password: Devise.friendly_token[0,20],
            level: 1,
            total_correct: 0,
        )
      end

      user
    end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20],
           level: 1,
           total_correct: 0,
           avatar: data['image'],
        )
    end

    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def update_question_statistics
    self.update_attribute(:total_correct, self.total_correct + 1)

    update_category_statistics

    if self.total_correct > calculate_level_up_threshold
      self.update_attribute(:level, self.level + 1)
    end
  end

  def change_muted_status
    muted = !self.muted
    self.update_attribute(:muted,muted)
  end

  def get_max_level_progression

    progress = self.level / MAX_LEVEL

    if progress > 1.0

      progress = 1.0
    end

    progress
  end

  private

  def calculate_level_up_threshold

    current_dynamic_threshold = get_recursive_definition(self.level, LEVEL_UP_DYNAMIC_THRESHOLD)
    current_static_threshold = LEVEL_UP_STATIC_THRESHOLD * self.level

    current_dynamic_threshold + current_static_threshold

  end

  def update_category_statistics

    category = self.active_player.current_category

    case category
      when self.aquatic_counter.categories.first
        increment_counter(self.aquatic_counter, category)

      when self.memes_counter.categories.first
        increment_counter(self.memes_counter, category)

      when self.basketball_counter.categories.first
        increment_counter(self.basketball_counter, category)

      when self.literature_counter.categories.first
        increment_counter(self.literature_counter, category)

      when self.music_counter.categories.first
        increment_counter(self.music_counter, category)

      when self.cs_counter.categories.first
        increment_counter(self.cs_counter, category)
      else
    end
  end

  def get_recursive_definition(times_to_iterate, numeric_definition)
    current_sum = 0

    if times_to_iterate - 1 > 0

      current_sum = get_recursive_definition(times_to_iterate - 1, numeric_definition)
    end

    numeric_definition * times_to_iterate + current_sum

  end

  def increment_counter(counter, category)
    counter.update_attribute(:questions_correct, counter.questions_correct + 1)
    check_category_achievement(counter.questions_correct, category)
  end

  def check_category_achievement(questions_correct, category)
    if questions_correct == CATEGORY_ACHIEVEMENT_THRESHOLD
      self.achievements << category.achievement
      self.update_attribute(:has_new_achievement, true)
    end
  end

  def build_counters

    build_aquatic_counter
    build_basketball_counter
    build_memes_counter
    build_literature_counter
    build_music_counter
    build_cs_counter
    memes_counter.categories << Category.find_by_title("Memes")
    basketball_counter.categories << Category.find_by_title("Basketball")
    literature_counter.categories << Category.find_by_title("Contemporary Literature")
    music_counter.categories << Category.find_by_title("Music")
    cs_counter.categories << Category.find_by_title("Computer Science")
    aquatic_counter.categories << Category.find_by_title("Aquatic Animals")
    true

  end

end
