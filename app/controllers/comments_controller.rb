class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /articles/:article_id/comments
  def index
    @comments = @article.comments.all
  end

  # GET /articles/:article_id/comments/1
  def show
  end

  # GET /articles/:article_id/comments/new
  def new
    @comment = @article.comments.new
  end

  # GET /articles/:article_id/comments/1/edit
  def edit
  end

  # POST /articles/:article_id/comments
  def create
    @comment = @article.comments.new(comment_params)
    @comment.posted_by = current_user

    request.env[:mixpanel_extra_properties] = {
      'Comment Body Length' => @comment.body.size
    }

    if @comment.save
      redirect_to [@article, :comments], notice: "Comment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/:article_id/comments/1
  def update
    if @comment.update(comment_params)
      redirect_to [@article, :comments], notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:article_id/comments/1
  def destroy
    @comment.destroy
    redirect_to article_comments_url, notice: "Comment was successfully destroyed."
  end

  private

  def set_article
    @article = Article.find_by(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = @article.comments.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end
