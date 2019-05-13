class EventCapacityValidator < ActiveModel::Validator
  def validate(record)
    if record.event.attendees.confirmed.count >= record.event.max_attendees
      record.errors[:event] << "Cette prestation a atteint le nombre de participants maximun."
    end
  end
end
