class Tag < ActiveRecord::Base
  has_and_belongs_to_many :series
  has_and_belongs_to_many :seasons
  
  VALID_COLORS = ["green", "red", "orange", "blue", "black"]
  
  validates_length_of :acronym, :is => 1
  validates_inclusion_of :acronym, :in => 'A'..'Z'
  validates_inclusion_of :color, :in => VALID_COLORS
  
  def self.for_series
    Tag.find :all, :order => 'priority DESC', :conditions => ['seasontag = "0"']
  end
  
  def self.for_seasons
    Tag.find :all, :order => 'priority DESC', :conditions => ['seasontag = "1"']
  end
  
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
