class RecommendController < ApplicationController

  def series
    # First 3 ids = shows user like
    # Last  2 ids = shows user dislike
    series = params["series"]

    Vote.create(likes: series.first(3), dislikes: series.last(2))
    
    votes = Vote.where("ARRAY[" + series[0].to_s + "," + series[1].to_s + "] <@  likes")
           votes.where("ARRAY[" + series[1].to_s + "," + series[2].to_s + "] <@  likes")
           votes.where("ARRAY[" + series[0].to_s + "," + series[2].to_s + "] <@  likes")

    recommendations = Hash.new(0)
    
    votes.each do |vote|
      vote.likes.each do |like|
        recommendations[like] += 1 unless series.include?(like)
      end
    end
    
    recommendSeries = filterRecommendations(recommendations)

    if recommendSeries.length < 4
      Serie.select(:id).order(like: :desc).limit(4-recommendSeries.length).each do |s|
        recommendSeries << s.id
      end
      render json: Serie.find(recommendSeries)
    else
      render json: Serie.find(recommendSeries)
    end
  end

  private

  def filterRecommendations(recommendations)
    top4_series = []
    
    while (top4_series.length < 4 && recommendations.length > 0)

      max_votes = recommendations.select {|k,v| v == recommendations.values.max }
      
      max_votes.each do |serie_id,votes|
        if top4_series.length < 4
          top4_series << serie_id 
          recommendations.delete(serie_id) 
        end
      end
    end

    return top4_series
  end

end
