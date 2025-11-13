require_relative '../models/student'

class StudentManager
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/

  attr_reader :students

  def initialize
    @students = []
  end

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
    puts "✅ Student created successfully: #{student}"
  end

  def list_students
    if @students.empty?
      puts "No students found."
    else
      puts "Students:"
      @students.each { |s| puts s }
    end
  end

  def find_student_by_input(input)
    return nil if input.nil? || input.empty?
    if integer_string?(input)
      @students.find { |s| s.id == input.to_i }
    else
      @students.find { |s| s.email.downcase == input.downcase }
    end
  end

  private

  def valid_email_format?(email)
    return false if email.nil? || email.empty?
    EMAIL_REGEX.match?(email)
  end

  def valid_name?(name)
    !name.nil? && !name.strip.empty?
  end

  def integer_string?(str)
    str.to_i.to_s == str
  end
end
