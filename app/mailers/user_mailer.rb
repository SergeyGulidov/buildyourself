class UserMailer < ActionMailer::Base
  default from: "yodafromlv@gmail.com"
  default reply_to: "yodafromlv@gmail.com"


def schedule_notifier(schedule)
  @text = {}
  @text["place_id"] = schedule.place_id
  old_locale = I18n.locale

  user = User.find(schedule.user_id) # get user from whom we sending

  subject = "Yoda.lv: " +  user.name || user.email

  @schedule = schedule
  @recipients = Subscriber.where("user_id = ? AND confirmed = ?", schedule.user_id, 1).all
 
  @recipients.each do |recipient|
    request_replacement_for_schedule(recipient, subject, @text).deliver
  end

  I18n.locale = old_locale
end


def request_replacement_for_schedule(recipient, subject, text)
  @text = text
  I18n.locale = recipient.lang
  
  @text["message"] = t :schedule_changed

  @text["link_to_read_more"] = "http://www.yoda.lv/" + recipient.lang + "/places/" + @text["place_id"].to_s
  @text["destroy_text"] = t :destroy_subs
  @text["link_to_destroy"] = "http://www.yoda.lv/subscribers/destroy?token=" + recipient.confirm_token
  mail to: recipient.email, subject: subject
end









def new_post_notifier(post)
  old_locale = I18n.locale

  user = User.find(post.user_id) # get user from whom we sending

  subject = "Yoda.lv: " +  user.name || user.email
  
  @recipients = Subscriber.where("user_id = ? AND confirmed = ?", post.user_id, 1).all
 
  @recipients.each do |recipient|
    request_replacement_for_post(recipient, subject, post).deliver
  end

  I18n.locale = old_locale
end


def request_replacement_for_post(recipient, subject, post)
  I18n.locale = recipient.lang
  @text = {}

  if recipient.lang == "ru"
      if post.message_ru.blank?
        @text["message"] = truncate( post.message_lv, :length => 150, :separator => '. ', :omission => '...')
        @text["title"] = post.title_lv
      else
        @text["message"] = truncate( post.message_ru, :length => 150, :separator => '. ', :omission => '...')
        @text["title"] = post.title_ru
      end
  else
      if post.message_lv.blank?
        @text["message"] = truncate( post.message_ru, :length => 150, :separator => '. ', :omission => '...')
        @text["title"] = post.title_ru
      else
        @text["message"] = truncate( post.message_lv, :length => 150, :separator => '. ', :omission => '...')
        @text["title"] = post.title_lv
      end
  end

  @text["link_to_read_more"] = "http://www.yoda.lv/" + recipient.lang + "/posts/" + post.id.to_s
  @text["destroy_text"] = t :destroy_subs
  @text["link_to_destroy"] = "http://www.yoda.lv/subscribers/destroy?token=" + recipient.confirm_token

  mail to: recipient.email, subject: subject
end





def new_feed_notifier(feed, locale)
  old_locale = I18n.locale
  I18n.locale = locale
  user = User.find(feed.user_id) # get user from whom we sending

  @destroy_text = t :destroy_subs
  @message = feed.message

  subject = "Yoda.lv: " +  user.name || user.email
  
  @recipients = Subscriber.where("user_id = ? AND confirmed = ?", feed.user_id, 1).all
 
  @recipients.each do |recipient|
    request_replacement(recipient, subject).deliver
  end

  I18n.locale = old_locale
end


def request_replacement(recipient, subject)
  @link_to_destroy = "http://www.yoda.lv/subscribers/destroy?token=" + recipient.confirm_token
  mail to: recipient.email, subject: subject
end



def greating(email, token, locale)
  old_locale = I18n.locale
  I18n.locale = locale

  @greeting = []
  subject = t :title_for_request
  @link_to_click = "http://www.yoda.lv/subscribers/confirm?token=" + token
  @link_to_destroy = "http://www.yoda.lv/subscribers/destroy?token=" + token
  @greeting[0] = t :your_request
  @greeting[1] = t :confirm_request
  @greeting[2] = t :destroy_request
  @greeting[3] = t :from_admin

  mail to: email, subject: subject
  I18n.locale = old_locale
end


# subscribe for madmimi api for only 10$ month

  # def greating
  #   mimi = MadMimi.new('yodafromlv@gmail.com', '2c787dd0e8d386f31382e5fba0911c7f')
  #   puts mimi.promotions
  #   options = {'promotion_name' => 'Greating','recipients' => 's.gulidov@gmail.com', 'from' => 'Yoda.lv administration <yodafromlv@gmail.com>', 'subject' => 'Test Subject' }
   
  #   yaml_body = { 'greeting' => 'Hello', 'name' => 'Sergey' }

  #   puts "||||||||||||||||" + mimi.send_mail(options, yaml_body) + "||||||||||||||||"
  # end
end
