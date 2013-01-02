class Report < ActiveRecord::Base
  belongs_to :user
  
  serialize :data, Hash
  
  def self.kinds 
    {:seasons_given => 0}
  end
  
  def self.send_as_mail
    
  end
end