class SeriesController < ApplicationController
  def index
    @series = Serie.all
  end

  def show
    @serie = Serie.find_by_id(params[:id])
    if @serie.nil?
      render :json => {
        :message => { :message => "Cannot find serie" }
      }
    end
  end

  def update
    @serie = Serie.find_by_id(params[:id])

    if @serie.nil?
      render :json => {
        :message => { :message => "Cannot find serie", :delete => false }
      }
    else
      @serie.update(serie_params)
    end

    render 'index'
  end

  def findByName
    @series = Serie.search_by_title(params[:name])
    if @series.nil?
      render :json => {
        :message => { :message => "Cannot find serie" }
      }
    end
    render 'index'
  end

  def findByCategory
    @series = Serie.search_by_category(params[:category, :category2, :category3]).order(like :desc).limit(28);
    if @series.nil?
      render :json => {
        :message => { :message => "Cannot find serie" }
      }
    end
    render 'index'
  end

  def best
    @series = Serie.order(like: :desc).limit(16)
  end

  def worst
    @series = Serie.order(dislike: :desc).limit(12)
  end

  private

  def serie_params
    params.require(:serie).permit(:like, :dislike)
  end
end
