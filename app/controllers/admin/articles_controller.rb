class Admin::ArticlesController < ApplicationController
  # show, new, edit, create and update
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin_user!

  # GET /articles
  def index
  if params[:search]
    @articles = current_admin_user.articles.search(params[:search]).most_recent
  else
    @articles = current_admin_user.articles.most_recent
  end
  end

  # GET /articles/1
  def show
    @user = current_admin_user
    @author = User.find(@article.user_id)
  end

  # GET /articles/new
  def new
    @article = Article.new
    @article.pictures.build
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = current_admin_user.articles.new(article_params)

      if @article.save
        redirect_to admin_articles_url, notice: 'Article was successfully updated.'
      else
        render :new
      end
  end

  # PATCH/PUT /articles/1
  def update
      if @article.update(article_params)
        redirect_to admin_articles_url, notice: 'Article was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    redirect_to admin_articles_url, notice: 'Article was successfully destroyed.'
  end

  # find all categorys matching id
  def category_attributes
    Article.where(category_id: params[:category])
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :published, :published_at, :category_id, :user_id, pictures_attributes: [:id, :name])
    end
end
