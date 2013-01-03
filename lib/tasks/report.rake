namespace :report do
  desc "Bla bla"
  task :send => :environment do
    Report.send_all_as_mail
  end
end
