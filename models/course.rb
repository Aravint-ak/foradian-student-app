class Course
  attr_reader :id
  attr_accessor :title, :code

  @@next_id = 1

  def initialize(title:, code:)
    @id = @@next_id
    @@next_id += 1
    @title = title.strip
    self.code = code.strip.upcase
  end

  def code=(val)
    @code = val.nil? ? nil : val.strip.upcase
  end

  def to_s
    "##{id} - #{title} (#{code})"
  end
end
