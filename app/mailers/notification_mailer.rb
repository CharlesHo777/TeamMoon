
class NotificationMailer < ApplicationMailer
  helper :application

  default from: 'teammars@t-rresources.com'

  def  notify_user(user, template)
    @user = user
    @template = template
    @url  = 'http://localhost:3000/'
    mail(to: [@user.email], subject: 'TeamMars Notification')
  end
end
