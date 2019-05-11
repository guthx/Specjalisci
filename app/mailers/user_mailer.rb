class UserMailer < ApplicationMailer
  def confirm(specialist)
    @specialist = specialist
    mail(to: @specialist.email, subject: 'Potwierdzenie dodania działalności')
  end
end
