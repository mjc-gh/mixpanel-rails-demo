# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer
class CommentMailerPreview < ActionMailer::Preview
  def notice
    CommentMailer.with(user: User.first, article: Article.first).notice
  end
end
