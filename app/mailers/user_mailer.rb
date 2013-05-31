class UserMailer < ActionMailer::Base
  default from: "yodafromlv@gmail.com"
  default reply_to: "yodafromlv@gmail.com"


def greating(email, token)
  @greeting = []
  subject = t :title_for_request
  @link_to_click = "http://www.yoda.lv/subscribers/confirm?token=" + token
  @link_to_destroy = "http://www.yoda.lv/subscribers/destroy?token=" + token
  @greeting[0] = t :your_request
  @greeting[1] = t :confirm_request
  @greeting[2] = t :destroy_request
  @greeting[3] = t :from_admin

  mail to: email, subject: subject
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
