class Scoreboard < ActiveRecord::Base

  has_many :weekly_counters, class_name: "CategoryCorrectCounter", foreign_key: "weekly_counter_id"
  has_many :monthly_counters, class_name: "CategoryCorrectCounter", foreign_key: "monthly_counter_id"
  has_many :all_time_counters, class_name: "CategoryCorrectCounter", foreign_key: "all_time_counter_id"

  before_create :build_weekly_counters, :build_monthly_counters, :build_all_time_counters

  def update_scoreboard(category, answer_correct)

    update_questions_counter(self.weekly_counters, category, answer_correct)
    update_questions_counter(self.monthly_counters, category, answer_correct)
    update_questions_counter(self.all_time_counters, category, answer_correct)
  end

  def update_questions_counter(group, category, is_correct)

    group.each do |counter|

      if counter.categories.first == category

        if is_correct

          counter.update_attribute(:questions_correct, counter.questions_correct + 1)
        end

        counter.update_attribute(:questions_answered, counter.questions_answered + 1)
        break
      end
    end
  end

  def check_if_reset_weekly

    if weekly_counters.first.present?

      if self.weekly_counters.first.created_at <= 1.week.ago

        reset_weekly
      end
    end
  end

  def check_if_reset_monthly

    if monthly_counters.first.present?

      if self.monthly_counters.first.created_at <= 1.month.ago

        reset_monthly
      end
    end
  end

  def get_total_answered(group)

    total = 0

    group.each do |counter|

      total += counter.questions_answered
    end
    total
  end

  def get_total_correct(group)

    total = 0

    group.each do |counter|

      total += counter.questions_correct
    end
    total
  end

  def get_category_correct(category, group)

    total = 0

    group.each do |counter|

      total += counter.questions_correct
    end
    total
  end

  private

  def reset_weekly

    self.weekly_counters.delete_all
    build_weekly_counters
  end

  def reset_monthly

    self.monthly_counters.delete_all
    build_monthly_counters
  end

  def build_weekly_counters

    Category.all.each do |category|

      counter = CategoryCorrectCounter.create
      counter.categories << category
      self.weekly_counters << counter
    end
  end

  def build_monthly_counters

    Category.all.each do |category|

      counter = CategoryCorrectCounter.create
      counter.categories << category
      self.monthly_counters << counter
    end
  end

  def build_all_time_counters

    Category.all.each do |category|

      counter = CategoryCorrectCounter.create
      counter.categories << category
      self.all_time_counters << counter
    end
  end

end
