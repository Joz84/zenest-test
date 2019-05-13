namespace :availability_scheduler do
  desc "This task is called by the Heroku scheduler add-on to update availability request status"
  task :update_availability_status => :environment do
    today = (DateTime.now).to_date
    requirements = Requirement.joins(:calendar_day).where('DATE(calendar_days.date) <= ?', today)
    availabilities = Availability.pending.includes(:requirement)
                                .where(requirement: requirements )
    availabilities.each { |availability| availability.update(status: "unavailable")}
  end
end
