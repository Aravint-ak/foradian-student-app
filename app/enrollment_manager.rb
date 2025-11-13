# app/enrollment_manager.rb
require_relative '../models/enrollment'

class EnrollmentManager
  attr_reader :enrollments

  def initialize(student_manager, course_manager)
    @student_manager = student_manager
    @course_manager = course_manager
    @enrollments = []
  end

  def enroll_student_in_course
    if @student_manager.students.empty? || @course_manager.courses.empty?
      puts "Need at least one student and one course to enroll."
      return
    end

    print "Enter Student Email (or ID): "
    s_input = gets&.chomp.to_s.strip
    student = @student_manager.find_student_by_input(s_input)
    unless student
      puts "Student not found."
      return
    end

    print "Enter Course Code (or ID): "
    c_input = gets&.chomp.to_s.strip
    course = @course_manager.find_course_by_input(c_input)
    unless course
      puts "Course not found."
      return
    end

    if @enrollments.any? { |e| e.student.id == student.id && e.course.id == course.id }
      puts "Error: Student is already enrolled in this course."
      return
    end

    enrollment = Enrollment.new(student: student, course: course)
    @enrollments << enrollment
    puts "✅ Enrollment successful: #{enrollment}"
  end

  def list_enrollments
    if @enrollments.empty?
      puts "No enrollments found."
    else
      puts "Enrollments:"
      @enrollments.each_with_index { |e, i| puts "#{i + 1}. #{e}" }
    end
  end

  def find_courses_by_student
    print "Enter Student Email (or ID): "
    s_input = gets&.chomp.to_s.strip
    student = @student_manager.find_student_by_input(s_input)
    unless student
      puts "Student not found."
      return
    end

    courses = @enrollments.select { |e| e.student.id == student.id }.map(&:course)
    if courses.empty?
      puts "#{student.name} is not enrolled in any course."
    else
      puts "Courses for #{student.name}:"
      courses.each { |c| puts c }
    end
  end

  def find_students_by_course
    print "Enter Course Code (or ID): "
    c_input = gets&.chomp.to_s.strip
    course = @course_manager.find_course_by_input(c_input)
    unless course
      puts "Course not found."
      return
    end

    students = @enrollments.select { |e| e.course.id == course.id }.map(&:student)
    if students.empty?
      puts "No students enrolled in #{course.title}."
    else
      puts "Students in #{course.title}:"
      students.each { |s| puts s }
    end
  end
end
