# app/course_manager.rb
require_relative '../models/course'

class CourseManager
  attr_reader :courses

  def initialize
    @courses = []
  end

  def create_course
    print "Enter Course Title: "
    title = gets&.chomp.to_s.strip
    print "Enter Course Code: "
    code = gets&.chomp.to_s.strip.upcase

    if title.empty? || code.empty?
      puts "Error: Title and code are required."
      return
    end

    if @courses.any? { |c| c.code == code }
      puts "Error: Course code already exists."
      return
    end

    course = Course.new(title: title, code: code)
    @courses << course
    puts "✅ Course created successfully: #{course}"
  end

  def list_courses
    if @courses.empty?
      puts "No courses found."
    else
      puts "Courses:"
      @courses.each { |c| puts c }
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

  private

  def integer_string?(str)
    str.to_i.to_s == str
  end
end

