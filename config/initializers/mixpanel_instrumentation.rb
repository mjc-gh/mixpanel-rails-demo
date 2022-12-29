Rails.application.config.to_prepare do
  if Rails.env.development?
    ActiveSupport::Notifications.unsubscribe 'process_action.action_controller'
    ActiveSupport::Notifications.unsubscribe 'deliver.action_mailer'
  end

  ActiveSupport::Notifications.subscribe 'process_action.action_controller', ProcessActionInstrument.new
  ActiveSupport::Notifications.subscribe 'deliver.action_mailer', DeliverActionMailerInstrument.new
end
