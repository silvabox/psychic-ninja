class OneAttendanceRule < Rule
  def initialize(context)
    super context
  end

  def run
    attendance = context[:attendance]
    context[:occurrences].each do |occurrence|
      @points = 1 if occurrence.start == attendance.occurrence.start
    end
    @points > 0 ? true : false
  end
end