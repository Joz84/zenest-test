class BlogArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  def index
    @articles = BlogArticle.active.ordered_by_published_at
  end

  def show
    @article = BlogArticle.friendly.find(params[:id])
  end
end
