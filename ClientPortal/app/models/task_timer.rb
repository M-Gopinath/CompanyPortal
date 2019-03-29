class TaskTimer < ApplicationRecord
	belongs_to :task
	belongs_to :employee


	def lap_time?
		(start_time - end_time).to_i.abs
	end

	def hours_format(total_time)
    if total_time.present?
      hours = total_time / 3600
      total_time -= hours * 3600

      minutes = total_time / 60
      total_time -= minutes * 60

      seconds = total_time

      "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
    else
      "00:00:00"
    end
  end

  def self.select_day_timer(day)
  	self.where("start_time >= ? && start_time <= ?", day.to_time.beginning_of_day,day.to_time.end_of_day)
  end
end
