class ProcessActionInstrument
  def call(name, started, finished, unique_id, payload)
    return unless payload[:response]&.status.to_i.in? 200..399
    return if payload[:request].path.starts_with?('/rails')

    user = event_user(payload)
    return unless user

    Rails.logger.tagged('ProcessActionInstrument') do |log|
      name = event_name(payload)
      props = event_properties(payload)

      TrackActionEventJob.perform_later user, name, props, payload[:request].ip
    end
  end

  private

  def event_name(payload)
    controller_name = payload[:controller][0..-11].underscore.gsub(%r(/), '_')

    case payload[:action]
    when 'index'
      "View #{controller_name.titleize}"
    else
      "#{payload[:action].titleize} #{controller_name.singularize.titleize}"
    end
  end

  def event_properties(payload)
    params = payload[:params]
    request = payload[:request]

    id = params[:id]

    {}.tap do |props|
      params.keys.each do |key|
        props["#{key.titleize} ID"] = params[key] if key.ends_with? '_id'
      end

      props["#{payload[:controller].demodulize[0..-11].singularize.titleize} ID"] = id if id
      props.update request.env[:mixpanel_extra_properties] if request.env.key? :mixpanel_extra_properties
    end
  end

  def event_user(payload)
    warden = payload[:request].env['warden']

    warden.user(:user) if warden.authenticated?(:user)
  end
end
