# app/menu.rb
class Menu
  def initialize(student_manager, course_manager, enrollment_manager)
    @student_manager = student_manager
    @course_manager = course_manager
    @enrollment_manager = enrollment_manager
  end

  def run
    puts "Welcome to Student-Course Management\n\n"
    loop do
      print_menu
      print "Enter choice: "
      choice = gets&.chomp
      break if choice.nil?

      case choice.to_i
      when 1 then @student_manager.create_student
      when 2 then @student_manager.list_students
      when 3 then @course_manager.create_course
      when 4 then @course_manager.list_courses
      when 5 then @enrollment_manager.enroll_student_in_course
      when 6 then @enrollment_manager.list_enrollments
      when 7 then @enrollment_manager.find_courses_by_student
      when 8 then @enrollment_manager.find_students_by_course
      when 9
        puts "Exiting... Goodbye!"
        break
      else
        puts "Invalid choice. Please enter 1–9."
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
end