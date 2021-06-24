class AnswerMailer < ApplicationMailer

  def notice
    @informant = params[:informant]
    @animal = params[:animal]
    @message = params[:message]
    @url = params[:url]

    mail(to: @animal.user.email, subject: "Animal Founder - Noticias de seu animal")
  end
end
