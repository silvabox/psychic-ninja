require "./lib/gamification"
require "ice_cube"

describe 'Gamification' do
  let(:time) { Time.now.beginning_of_month }

  it 'should award 1 point for an attendance' do
    attendances = create_attendances(time)

    gamification = Gamification.new(create_occurrences, attendances)

    attendance = attendances.first
    
    gamification.run(attendance).should eq 1
  end

  it 'should award 1 extra point for one extra attendance in same month' do
    attendances = create_attendances(time, time.advance(days: 7))

    gamification = Gamification.new(create_occurrences, attendances)

    attendance = attendances.first
    
    gamification.run(attendance).should eq 2
  end

  it 'should award 2 extra points for two extra attendances in same month' do
    attendances = create_attendances(time, time.advance(days: 7), time.advance(days: 14))

    gamification = Gamification.new(create_occurrences, attendances)

    attendance = attendances.first
    
    gamification.run(attendance).should eq 3
  end

  it 'should award 3 extra points for three extra attendances in same month' do
    attendances = create_attendances(time, time.advance(days: 7), time.advance(days: 14), time.advance(days: 21))

    gamification = Gamification.new(create_occurrences, attendances)

    attendance = attendances.first
    
    gamification.run(attendance).should eq 4
  end

  it 'should award 2 extra points for complete attendances in month' do
    attendances = create_attendances(time, time.advance(days: 7), time.advance(days: 14), time.advance(days: 21), time.advance(days: 28))

    gamification = Gamification.new(create_occurrences, attendances)

    attendance = attendances.first
    
    gamification.run(attendance).should eq 7
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

  def create_double(start, name, type)
    occurrence = double "#{type}_#{name}_#{start.strftime('%Y%m%d%H%M')}".to_sym
    occurrence.should_receive(:start).at_least(1).times.and_return(start)
  end
end