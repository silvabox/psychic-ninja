require "./lib/gamification"
require "ice_cube"

describe 'Gamification' do
  let(:time) { Time.now.beginning_of_month }

  context 'given 1 attendance' do
    it 'awards 1 point' do  
      create_gamification create_attendances(time)
      @gamification.run(@attendance).should eq 1
    end
  end

  context 'given 2 attendances in same month' do
    it 'awards 1 extra point' do
      create_gamification create_attendances(time, time.advance(days: 7))
      @gamification.run(@attendance).should eq 2
    end
  end

  context 'given 3 attendances in same month' do
    it 'awards 2 extra points' do
      create_gamification create_attendances(time, time.advance(days: 7), time.advance(days: 14))
      @gamification.run(@attendance).should eq 3
    end
  end

  context 'given 4 extra attendances in same month' do  
    it 'awards 3 extra points' do
      create_gamification create_attendances(time, time.advance(days: 7), time.advance(days: 14), time.advance(days: 21))
      @gamification.run(@attendance).should eq 4
    end
  end

  context 'given complete attendance in month' do
    it 'awards 2 extra points' do
      create_gamification create_attendances(time, time.advance(days: 7), time.advance(days: 14), time.advance(days: 21), time.advance(days: 28))
      @gamification.run(@attendance).should eq 7
    end
  end

  def create_gamification(attendances)
    @gamification = Gamification.new(Context.new(occurrences: create_occurrences, attendances: attendances))
    @attendance = attendances.first
  end

  def create_occurrences
    schedule = IceCube::Schedule.new(time.to_date.beginning_of_month.advance(weeks: -1))
    schedule.add_recurrence_rule IceCube::Rule.weekly
    schedule.first(7).map { |occurrence| create_occurrence(occurrence.start_time, :occurrence) }
  end

  def create_occurrence(start, name)
    # occurrence = double :occurrence
    occurrence = double "occurrence_#{name}_#{start.strftime('%Y%m%d%H%M')}".to_sym
    occurrence.should_receive(:start).at_least(1).times.and_return(start)
    occurrence
  end

  def create_attendances(*occurring_at_times)
    occurring_at_times.map do |time|
      attendance = double :attendance
      attendance.should_receive(:occurrence).at_least(1).times.and_return create_occurrence(time, :attendance)
      attendance
    end
  end

  def create_attendance(start, name)
    attendance = double :attendance
    attendance.should_receive(:occurrence).at_least(1).times.and_return create_occurrence(time, :attendance)
  end
end