
require 'active_support/all'

class Gamification
  def initialize(occurrences, attendances)
    @occurrences = occurrences
    @attendances = attendances
    @points = 0
  end

  def run(attendance)
    one_attendance attendance
    extra_attendances_in_month attendance
    all_attendances_in_month attendance
    @points
  end

  def one_attendance(attendance)
    @occurrences.each do |occurrence|
      @points += 1 if occurrence.start == attendance.occurrence.start
    end
  end

  def extra_attendances_in_month(attendance)
    month_start =  attendance.occurrence.start.beginning_of_month
    month_end = attendance.occurrence.start.end_of_month

    attendances_in_month = @attendances.reject do |a|
      a.occurrence.start
      a.occurrence.start < month_start || a.occurrence.start > month_end || a.occurrence.start == attendance.occurrence.start
    end
    @points += attendances_in_month.count
  end

  def all_attendances_in_month(attendance)
    month_start =  attendance.occurrence.start.beginning_of_month
    month_end = attendance.occurrence.start.end_of_month

# find all occurrences in the month
    occurrences_in_month = @occurrences.reject do |o|
      o.start < month_start || o.start > month_end
    end
    occurrences_in_month.reject! do |o|
      @att
    end
    @points += 2 if occurrences_in_month.all? do |o|
      @attendances.any? { |a| a.occurrence.start == o.start }
    end

  end
end