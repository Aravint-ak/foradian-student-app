# console_app.rb
require_relative './student'
require_relative './course'
require_relative './enrollment'

class App
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/

  def initialize
    @students = []
    @courses = []
    @enrollments = []
  end

  def run
    puts "Welcome to Student-Course Management\n\n"
    loop do
      print_menu
      print "Enter choice: "
      choice = gets&.chomp
      break if choice.nil?
      case choice.to_i
      when 1 then create_student
      when 2 then list_students
      when 3 then create_course
      when 4 then list_courses
      when 5 then enroll_student_in_course
      when 6 then list_enrollments
      when 7 then find_courses_by_student
      when 8 then find_students_by_course
      when 9
        puts "Exiting... Goodbye!"
        break
      else
        puts "Invalid choice. Please enter a number between 1 and 9."
      end
      puts "\n"
    end
  end

  private

  def print_menu
    puts "1. Create Student"
    puts "2. List Students"
    puts "3. Create Course"
    puts "4. List Courses"
    puts "5. Enroll Student in Course"
    puts "6. List Enrollments"
    puts "7. Find Courses by Student"
    puts "8. Find Students by Course"
    puts "9. Exit"
  end

  # 1
  def create_student
    print "Enter Student Name: "
    name = gets&.chomp.to_s.strip
    print "Enter Student Email: "
    email = gets&.chomp.to_s.strip.downcase

    unless valid_name?(name)
      puts "Error: Name can't be blank."
      return
    end

    unless valid_email_format?(email)
      puts "Error: Invalid email format."
      return
    end

    if @students.any? { |s| s.email == email }
      puts "Error: Email already in use."
      return
    end

    student = Student.new(name: name, email: email)
    @students << student
    puts "Student created successfully: #{student}"
  end

  # 2
  def list_students
    if @students.empty?
      puts "No students found."
    else
      puts "Students:"
      @students.each { |s| puts s.to_s }
    end
  end

  # 3
  def create_course
    print "Enter Course Title: "
    title = gets&.chomp.to_s.strip
    print "Enter Course Code: "
    code = gets&.chomp.to_s.strip.upcase

    unless valid_name?(title)
      puts "Error: Title can't be blank."
      return
    end

    if code.empty?
      puts "Error: Course code can't be blank."
      return
    end

    if @courses.any? { |c| c.code == code }
      puts "Error: Course code already exists."
      return
    end

    course = Course.new(title: title, code: code)
    @courses << course
    puts "Course created successfully: #{course}"
  end

  #4
  def list_courses
    if @courses.empty?
      puts "No course found."
    else
      puts "Courses:"
      @courses.each { |s| puts s.to_s }
    end
  end

  # 5
  def enroll_student_in_course
    if @students.empty? || @courses.empty?
      puts "Need at least one student and one course to enroll."
      return
    end

    print "Enter Student Email (or ID): "
    input = gets&.chomp.to_s.strip
    student = find_student_by_input(input)
    unless student
      puts "Student not found."
      return
    end

    print "Enter Course Code (or ID): "
    cinput = gets&.chomp.to_s.strip
    course = find_course_by_input(cinput)
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
    puts "Enrollment successful: #{enrollment}"
  end

  # 6
  def list_enrollments
    if @enrollments.empty?
      puts "No enrollments found."
    else
      puts "Enrollments:"
      @enrollments.each_with_index do |e, i|
        puts "#{i+1}. #{e}"
      end
    end
  end

  # 7
  def find_courses_by_student
    print "Enter Student Email (or ID): "
    input = gets&.chomp.to_s.strip
    student = find_student_by_input(input)
    unless student
      puts "Student not found."
      return
    end

    courses = @enrollments.select { |e| e.student.id == student.id }.map(&:course).uniq
    if courses.empty?
      puts "#{student.name} is not enrolled in any course."
    else
      puts "Courses for #{student.name}:"
      courses.each { |c| puts c.to_s }
    end
  end

  # 8
  def find_students_by_course
    print "Enter Course Code (or ID): "
    input = gets&.chomp.to_s.strip
    course = find_course_by_input(input)
    unless course
      puts "Course not found."
      return
    end

    students = @enrollments.select { |e| e.course.id == course.id }.map(&:student).uniq
    if students.empty?
      puts "No students enrolled in #{course.title}."
    else
      puts "Students in #{course.title}:"
      students.each { |s| puts s.to_s }
    end
  end

  # helpers
  def valid_email_format?(email)
    return false if email.nil? || email.empty?
    EMAIL_REGEX.match?(email)
  end

  def valid_name?(name)
    !name.nil? && !name.strip.empty?
  end

  def find_student_by_input(input)
    return nil if input.nil? || input.empty?
    if integer_string?(input)
      @students.find { |s| s.id == input.to_i }
    else
      @students.find { |s| s.email.downcase == input.downcase }
    end
  end

  def find_course_by_input(input)
    return nil if input.nil? || input.empty?
    if integer_string?(input)
      @courses.find { |c| c.id == input.to_i }
    else
      @courses.find { |c| c.code.upcase == input.upcase }
    end
  end

  def integer_string?(str)
    str.to_i.to_s == str
  end
end

# run
if $0 == __FILE__
  App.new.run
end
