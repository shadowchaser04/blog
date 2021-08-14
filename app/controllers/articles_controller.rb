class ArticlesController < ApplicationController

  # GET /articles
  def index
    if params[:category].blank?
      @articles = Article.all
    else
      @articles = category_attributes.most_recent.published
    end
  end

  # GET /articles/1
  def show
    @article = Article.find(params[:id])
    @author = User.find(@article.user_id)
    # increment page count
    @article.increment!(:pagecount)
  end

  # find all categorys matching id
  def category_attributes
    Article.where(category_id: params[:category])
  end

end
