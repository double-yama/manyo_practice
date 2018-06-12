class NoticeMailer < ApplicationMailer
  default from: "seino.tomoyuki.with.the.creature@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #
  def sendmail_confirm
    @greeting = "元気ー？"
    mail to: "k.sakimura@ashita-team.com"
    # mail to: "m.seino@ashita-team.com"
  end

  def sendmail_confirm_task(task)
    @greeting = "元気ー？"
    @task = task
    # mail to: "m.seino@ashita-team.com"
    mail to: "k.sakimura@ashita-team.com"
    # mail to: "keishi.takahashi@ashita-team.com"
  end
end
