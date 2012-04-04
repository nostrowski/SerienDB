class Tag < ActiveRecord::Base
  has_and_belongs_to_many :series
  
  VALID_COLORS = ["green", "red", "orange", "blue", "black"]
  
  validates_length_of :acronym, :is => 1
  validates_inclusion_of :acronym, :in => 'A'..'Z'
  validates_inclusion_of :color, :in => VALID_COLORS
  
  def priority_up!
    new_priority = self.priority + 1
    other_tag = Tag.find_by_priority(new_priority)
    unless other_tag == nil then
      other_tag.priority = self.priority
      other_tag.save
      self.priority = new_priority
      self.save
    end
  end
  
  def priority_down!
    new_priority = self.priority - 1
    other_tag = Tag.find_by_priority(new_priority)
    unless other_tag == nil then
      other_tag.priority = self.priority
      other_tag.save
      self.priority = new_priority
      self.save
    end
  end
  
  def full_description
    self.acronym + " " + self.comment
  end
end
