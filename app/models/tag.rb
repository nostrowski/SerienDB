class Tag < ActiveRecord::Base
  has_and_belongs_to_many :series
  
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
