class AnswersMailer < ApplicationMailer
  def notify_question_owner
    mail(to: 'bernardorubin@gmail.com', subject: 'test')
  end
end
