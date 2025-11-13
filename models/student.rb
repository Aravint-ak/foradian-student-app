class Student
  attr_reader :id
  attr_accessor :name, :email

  @@next_id = 1

  def initialize(name:, email:)
    @id = @@next_id
    @@next_id += 1
    @name = name.strip
    @email = email.strip.downcase
  end

  def email=(val)
    @email = val.nil? ? nil : val.strip.downcase
  end

  def to_s
    "##{id} - #{name} (#{email})"
  end
end
