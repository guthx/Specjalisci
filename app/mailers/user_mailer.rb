class UserMailer < ApplicationMailer
  def confirm(specialist)
    @specialist = specialist
    mail(to: @specialist.email, subject: 'Potwierdzenie dodania działalności')
  end

  def confirm_foreign(specialist)
    @specialist = specialist
    mail(to: @specialist.email, subject: 'Potwierdzenie rejestracji działalności')
  end
end
