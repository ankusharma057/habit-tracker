class HabitCheckin < ApplicationRecord
  validates :date, uniqueness: { scope: :habit_id }
  belongs_to :habit
end
