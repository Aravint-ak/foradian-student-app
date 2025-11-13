# console_app.rb
require_relative './app/student_manager'
require_relative './app/course_manager'
require_relative './app/enrollment_manager'
require_relative './app/menu'

student_manager = StudentManager.new
course_manager = CourseManager.new
enrollment_manager = EnrollmentManager.new(student_manager, course_manager)

menu = Menu.new(student_manager, course_manager, enrollment_manager)
menu.run
