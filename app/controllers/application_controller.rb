class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from Exception, with: :generic_exception
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # rescue_from StandardError, with: :record_not_found

  protected
  def record_not_found(error)
    notify_telegram(error)
    raise error
  end

  def generic_exception(error)
    notify_telegram(error)
    raise error
  end

  private

  # Doc API Telegram
  # https://core.telegram.org/bots/api#html-style
  def notify_telegram(error)
    message = []
    fields = [
        {name: 'Class', value: self.class.name},
        {name: 'Method', value: self.action_name},
        {name: 'Message', value: error.message}
    ]
    fields.each do |field|
      message << "<b>#{field[:name]}:</b> #{field[:value].gsub(/[<>&]/,'')}"
    end
    Telegram.bot.send_message(chat_id: 166127998, text: message.join("\n"), parse_mode: 'HTML')
  end

end
