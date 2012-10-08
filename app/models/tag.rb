class Tag < ActiveRecord::Base
  has_and_belongs_to_many :series
  has_and_belongs_to_many :seasons
  
  VALID_COLORS = ["green", "red", "orange", "blue", "black"]
  
  validates_length_of :acronym, :is => 1
  validates_inclusion_of :acronym, :in => 'A'..'Z'
  validate :valid_color?
  
  def self.for_series
    Tag.find :all, :order => 'priority DESC', :conditions => ['seasontag = "0"']
  end
  
  def self.for_seasons
    Tag.find :all, :order => 'priority DESC', :conditions => ['seasontag = "1"']
  end
  
  def self.hex_color?(value)
    return false unless value
    /^#(?:[0-9a-f]{3})(?:[0-9a-f]{3})?$/i.match(value).nil? ? false : true
  end
  
  def valid_color?
    unless self.class.hex_color?(self.color) || VALID_COLORS.include?(self.color)
      errors.add(:color, "Siehe Beschreibung")
    end
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
