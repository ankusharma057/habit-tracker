class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_checkins

  def checked_in_dates
    habit_checkins.pluck(:date).sort
  end

  def current_streak
    streak = 0
    date = Date.today

    while checked_in_dates.include?(date)
      streak += 1
      date -= 1
    end
    streak
  end

  def longest_streak
    streaks = []
    current_streak = 1
    sorted = checked_in_dates

    sorted.each_cons(2) do |a, b|
      if b == a + 1
        current_streak += 1
      else
        streaks << current_streak
        current_streak = 1
      end
    end

    streaks << current_streak
    streaks.max || 0
  end

  def consistency_percentage
    days_since_creation = (Date.today - created_at.to_date).to_i + 1
    return 0 if days_since_creation <= 0

    (habit_checkins.count.to_f / days_since_creation * 100).round(2)
  end

end
