class PagesController < ApplicationController

  def welcome
    @news = Category.find_by(name: :news).articles.published.most_recent
    @reviews = Category.find_by(name: :reviews).articles.published.most_recent
  end

end
