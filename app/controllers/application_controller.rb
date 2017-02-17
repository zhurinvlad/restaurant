class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from Exception, with: :notify_me
  rescue_from StandardError, with: :notify_me

  protected
  def notify_me(error)
    notify_telegram(error)
    # notify_email(error)
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
    # chat '-183578090'
    # me 166127998
    # https://github.com/telegram-bot-rb/telegram-bot
    Telegram.bot.send_message(chat_id: '-183578090', text: message.join("\n"), parse_mode: 'HTML')
  end

end
