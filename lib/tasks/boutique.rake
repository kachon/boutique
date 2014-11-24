namespace :boutique do
  desc "TASK1"
  task :task1 => :environment do
    Rails.logger.info "Start task1"
    count = 0
    while true
      Rails.logger.info "Count #{count}"
      count += 1
      sleep 5
    end
    Rails.logger.info "End task1"
  end

  desc "TASK2"
  task :task2 => :environment do
  end
end