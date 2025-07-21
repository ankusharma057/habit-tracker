class HabitCheckinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit

  def create
    @habit.habit_checkins.create(date: params[:date])
    redirect_to @habit
  end

  def destroy
    checkin = @habit.habit_checkins.find_by(date: params[:date])
    checkin&.destroy
    redirect_to @habit
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
  end
end
