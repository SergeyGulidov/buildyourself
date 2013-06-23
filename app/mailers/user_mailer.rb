class UserMailer < ActionMailer::Base
  default from: "yodafromlv@gmail.com"
  default reply_to: "yodafromlv@gmail.com"


# notify when schedule updated or created
def schedule_notifier(schedule)
  old_locale = I18n.locale
  @text = {}
  subject, recipients = find_our_more_info(schedule)
  @text["place_id"] = schedule.place_id
 
  recipients.each do |recipient|
    request_replacement_for_schedule(recipient, subject).deliver
  end

  I18n.locale = old_locale
end


def request_replacement_for_schedule(recipient, subject)
  I18n.locale = recipient.lang
  
  @text["message"] = t :schedule_changed
  @text["link_to_read_more"] = "http://www.yoda.lv/" + recipient.lang + "/places/" + @text["place_id"].to_s
  @text["destroy_text"] = t :destroy_subs
  @text["link_to_destroy"] = "http://www.yoda.lv/subscribers/destroy?token=" + recipient.confirm_token
  mail to: recipient.email, subject: subject
end



  # notify when post approved
  def new_post_notifier(post)
    old_locale = I18n.locale
    @text = {}
    subject, recipients = find_our_more_info(post)
   
    recipients.each do |recipient|
      request_replacement_for_post(recipient, subject, post).deliver
    end

    I18n.locale = old_locale
  end


  def request_replacement_for_post(recipient, subject, post)
    I18n.locale = recipient.lang
    

    if recipient.lang == "ru"
        if post.message_ru.blank?
          @text["message"] = post.message_lv[0..250] + "..."
          @text["title"] = post.title_lv
        else
          @text["message"] = post.message_ru[0..250] + "..."
          @text["title"] = post.title_ru
        end
    else
        if post.message_lv.blank?
          @text["message"] = post.message_ru[0..250] + "..."
          @text["title"] = post.title_ru
        else
          @text["message"] = post.message_lv[0..250] + "..."
          @text["title"] = post.title_lv
        end
    end

    @text["link_to_read_more"] = "http://www.yoda.lv/" + recipient.lang + "/posts/" + post.id.to_s
    @text["destroy_text"] = t :destroy_subs
    @text["link_to_destroy"] = "http://www.yoda.lv/subscribers/destroy?token=" + recipient.confirm_token

    mail to: recipient.email, subject: subject
  end



  # notify when feed saved
  def new_feed_notifier(feed)

    old_locale = I18n.locale
    subject, recipients = find_our_more_info(feed)

    @message = feed.message

   
    recipients.each do |recipient|
      request_replacement(recipient, subject).deliver
    end

    I18n.locale = old_locale
  end

  def request_replacement(recipient, subject)
    I18n.locale = recipient.lang
    @destroy_text = t :destroy_subs
    @link_to_destroy = "http://www.yoda.lv/subscribers/destroy?token=" + recipient.confirm_token
    mail to: recipient.email, subject: subject
  end


  # approve email address
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


  ### helpers

  def find_our_more_info(source)
    user = User.find(source.user_id)
    subject = "Yoda.lv: " +  user.name || user.email
    recipients = Subscriber.where("user_id = ? AND confirmed = ?", source.user_id, 1).all
    return subject, recipients
  end

end
