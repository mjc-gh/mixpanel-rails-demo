class TrackDeliverActionMailerJob < ApplicationJob
  queue_as :low

  def perform(email, mailer_name, subject)
    user = User.find_by(email: email)

    return unless user

    event_name = mailer_name.titleize
    event_props = { 'Subject' => subject }

    TrackActionEventJob.perform_later user, event_name, event_props
  end
end
