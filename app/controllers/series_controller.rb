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

  private

  def serie_params
    params.require(:serie)
  end
end
