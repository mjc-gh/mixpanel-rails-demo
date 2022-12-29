class TrackActionEventJob < ApplicationJob
  queue_as :low

  def perform(user, event_name, event_properties, ip = nil)
    debug_event user, event_name, event_properties

    ip ||= user.current_sign_in_ip || user.last_sign_in_ip

    mixpanel_client.track user.public_id, event_name, event_properties, ip

    return unless people_set_recent? user

    mixpanel_client.people.set user.public_id, expand_user_properties(user), ip, {
      '$ignore_time' => 'true'
    }

    user.update_column :mixpanel_profile_last_set_at, Time.current
  end

  private

  def expand_user_properties(user)
    { '$email' => user.email,
      '$last_seen' => user.current_sign_in_at,
      '$created' => user.created_at,
      'sign_in_count' => user.sign_in_count }
  end

  def people_set_recent?(user)
    user.mixpanel_profile_last_set_at.nil? ||
      user.mixpanel_profile_last_set_at < 3.days.ago
  end

  def mixpanel_client
    @mixpanel_client ||= Mixpanel::Tracker.new(Rails.application.credentials[:mixpanel_token])
  end

  def debug_event(user, event_name, event_properties)
    Rails.logger.debug(
      ActiveSupport::LogSubscriber.new.send(
        :color, "[TrackActionEventJob] #{user.public_id} - #{event_name} - #{event_properties}", :green
      )
    )
  end
end
