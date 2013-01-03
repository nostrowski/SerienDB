class Report < ActiveRecord::Base
  belongs_to :user
  
  serialize :data, Hash
  
  def self.kinds 
    {:seasons_given => 0}
  end
  
  def self.send_all_as_mail
    User.all.each do |user|
      text = Array.new
      unless user.email_valid? then
        user.reports.delete_all
      else
        user.reports.where(:kind => kinds[:seasons_given]).each do |report|
          seasons = ""
          report.data[:seasons].each do |season|
            if season == 0 then
              seasons += I18n.translate('series.show.pilot')
            else
              seasons += I18n.translate('series.show.season')
              seasons += " #{season}"
            end
            seasons += ", " unless season == report.data[:seasons].last
          end
          text << I18n.translate('report.seasons_given', :name => User.find(report.data[:from_user]).fullname, :series => Series.find(report.data[:series]).name, :seasons => seasons)
        end
      end
      UserMailer.send_report(user, text) if text.size > 0
    end
  end
end