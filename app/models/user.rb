class User < ActiveRecord::Base
  has_many :players, foreign_key: "uid"
  has_one :active_player, class_name: "Player", foreign_key: "active_player_id"
  has_and_belongs_to_many :achievements
  has_one :aquatic_counter, class_name: "CategoryCorrectCounter", foreign_key: "aquatic_counter_id"
  has_one :memes_counter, class_name: "CategoryCorrectCounter", foreign_key: "memes_counter_id"
  has_one :basketball_counter, class_name: "CategoryCorrectCounter", foreign_key: "basketball_counter_id"
  has_one :literature_counter, class_name: "CategoryCorrectCounter", foreign_key: "literature_counter_id"
  has_one :music_counter, class_name: "CategoryCorrectCounter", foreign_key: "music_counter_id"
  has_one :cs_counter, class_name: "CategoryCorrectCounter", foreign_key: "cs_counter_id"
  before_create :build_counters
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.level = 1
      user.total_correct = 0

      unless user
        user = User.create(
            email: data["email"],
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
           email: data["email"],
           password: Devise.friendly_token[0,20],
           level: 1,
           total_correct: 0,
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

  private

  def build_counters

    build_aquatic_counter
    build_basketball_counter
    build_memes_counter
    build_literature_counter
    build_music_counter
    build_cs_counter
    memes_counter.categories << Category.all.find_by_title("Memes");
    basketball_counter.categories << Category.all.find_by_title("Basketball");
    music_counter.categories << Category.all.find_by_title("Music");
    cs_counter.categories << Category.all.find_by_title("Computer Science");
    aquatic_counter.categories << Category.all.find_by_title("Aquatic Animals");
    true

  end

end
