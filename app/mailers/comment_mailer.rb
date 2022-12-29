class CommentMailer < ApplicationMailer
  def notice
    @article = params[:article]

    mail to: params[:user].email, subject: 'You have a new comment on your article'
  end
end
