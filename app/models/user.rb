class User < ActiveRecord::Base
  has_and_belongs_to_many :seasons
  
  attr_reader :fullname
  
  def fullname
    @fullname ||= (firstname + " " + lastname)
  end
end
