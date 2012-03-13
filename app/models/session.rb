class Session < ActiveRecord::Base
  belongs_to :user
  
  def self.drop_old
    Session.all.each do |session|
      if session.created_at < (Time.now - 7.days) then
        session.destroy
      end
    end
  end
end
