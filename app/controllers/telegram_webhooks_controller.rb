class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  context_to_action!
  # bin/rake telegram:bot:poller
  def start(*)
    respond_with :message, text: t('.content')
  end

  def love_is(*)
    is =[
    'позволять ей класть в бутерброды лук',
    'читать вместе каждое утро свой гороскоп',
    'протянуть полотенце, когда в глаза попал шампунь',
    'сказать что блюдо, которое она приготовила очень вкусное, даже если это не так',
    'уметь готовить для себя, когда она кормит ребенка',
    'за минуту до его прихода освежиться духами',
    'сполоснуть ванну после того как искупался',
    'вместе клеить марки на поздравительные открытки',
    'в воскресное утро разбудить его вкусным запахом завтрака',
    'позволить ему играть за свою команду',
    'не быть собственником',
    'оставаться спокойной, когда свежеубранная комната опять загрязнится',
    'быть причиной того, что ее коронное блюдо подгорело',
    'не читать писем друг-друга',
    'напомнить ему, что он был самым интересным мужчиной на вечернике',
    'приготовить ему сладкое, даже если ты на диете',
    'согреть его сторону кровати когда он должен прийти поздно',
    'яркое солнце в дождливый день',
    'оставить ваши инициалы на дереве',
    'не становиться слишком подозрительным, когда она опаздывает на свидание',
    'украсть поцелуй, когда вы остановились перед светофором',
    'освободить от домашних хлопот в день рождения',
    'первым пробовать ее новые блюда',
    'позволить ему самому заняться ремонтом',
    'накормить его горячей едой, когда он приходит поздно',
    'чувствовать, что этот родившийся',
    'почистить лобовое стекло на его машине',
    'утянуть ее в кусты',
    'показать свою любовь принеся кофе в постель',
    'досчитать до 10 вместо того чтобы кричать',
    'потерять аппетит',
    'сопровождать ее на сезонных распродажах',
    'найти на сиденье машины розу',
    'оставлять послания на зеркале в ванной',
    'позволить ей говорить по межгороду со своим дедушкой',
    'уметь незаметно обольщать его',
    'не спешить, когда проходите мимо магазина для новобрачных',
    'пойти за пиццой когда она слишком устала чтобы готовить',
    'вместе убирать квартиру после визита гостей',
    'на ее день родения поставить на торт меньше свечек']

    respond_with :message, text: is[rand(0..38)]
  end

  def help(*)
    respond_with :message, text: t('.content')
  end

  def memo(*args)
    if args.any?
      session[:memo] = args.join(' ')
      respond_with :message, text: t('.notice')
    else
      respond_with :message, text: t('.prompt')
      save_context :memo
    end
  end

  def remind_me
    to_remind = session.delete(:memo)
    reply = to_remind || t('.nothing')
    respond_with :message, text: reply
  end

  def keyboard(value = nil, *)
    if value
      respond_with :message, text: t('.selected', value: value)
    else
      save_context :keyboard
      respond_with :message, text: t('.prompt'), reply_markup: {
          keyboard: [t('.buttons')],
          resize_keyboard: true,
          one_time_keyboard: true,
          selective: true,
      }
    end
  end

  def inline_keyboard
    respond_with :message, text: t('.prompt'), reply_markup: {
        inline_keyboard: [
            [
                {text: t('.alert'), callback_data: 'alert'},
                {text: t('.no_alert'), callback_data: 'no_alert'},
            ],
            [{text: t('.repo'), url: 'https://github.com/telegram-bot-rb/telegram-bot'}],
        ],
    }
  end

  def callback_query(data)
    if data == 'alert'
      answer_callback_query t('.alert'), show_alert: true
    else
      answer_callback_query t('.no_alert')
    end
  end

  def message(message)
    respond_with :message, text: t('.content', text: message['text'])
  end

  def inline_query(query, offset)
    query = query.first(10) # it's just an example, don't use large queries.
    t_description = t('.description')
    t_content = t('.content')
    results = 5.times.map do |i|
      {
          type: :article,
          title: "#{query}-#{i}",
          id: "#{query}-#{i}",
          description: "#{t_description} #{i}",
          input_message_content: {
              message_text: "#{t_content} #{i}",
          },
      }
    end
    answer_inline_query results
  end

  # As there is no chat id in such requests, we can not respond instantly.
  # So we just save the result_id, and it's available then with `/last_chosen_inline_result`.
  def chosen_inline_result(result_id, query)
    session[:last_chosen_inline_result] = result_id
  end

  def last_chosen_inline_result
    result_id = session[:last_chosen_inline_result]
    if result_id
      respond_with :message, text: t('.selected', result_id: result_id)
    else
      respond_with :message, text: t('.prompt')
    end
  end

  def action_missing(action, *_args)
    if command?
      respond_with :message, text: t('telegram_webhooks.action_missing.command', command: action)
    else
      respond_with :message, text: t('telegram_webhooks.action_missing.feature', action: action)
    end
  end
end