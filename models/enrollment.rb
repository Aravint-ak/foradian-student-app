# enrollment.rb
class Enrollment
  attr_reader :student, :course

  def initialize(student:, course:)
    @student = student
    @course = course
  end

  def to_s
    "#{student.name} (#{student.email}) => #{course.title} (#{course.code})"
  end
end
