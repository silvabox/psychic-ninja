require './lib/rules/attendance/one_attendance_rule'

describe OneAttendanceRule do 
  let(:time) { Time.now.beginning_of_month }
  let(:occurrences) { create_occurrences }

  context 'given 1 attendance' do

    let(:attendance) { create_attendance(time, :attendance) }

    it 'awards 1 point' do
      rule = OneAttendanceRule.new(Context.new( { occurrences: occurrences, attendance: attendance }))
      rule.run.should be_true
      rule.points.should eq 1
    end
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

  def create_attendance(start, name)
    attendance = double :attendance
    attendance.should_receive(:occurrence).at_least(1).times.and_return create_occurrence(time, :attendance)
    attendance
  end
end