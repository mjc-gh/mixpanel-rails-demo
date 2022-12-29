class DeliverActionMailerInstrument
  def call(name, started, finished, unique_id, payload)
    payload[:to].each do |email|
      TrackDeliverActionMailerJob.perform_later email, payload[:mailer], payload[:subject]
    end
  end
end
