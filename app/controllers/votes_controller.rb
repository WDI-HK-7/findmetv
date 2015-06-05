class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def create
    @vote = Vote.new(vote_params)

    @vote.save
  end

  private

  def vote_params
    params.require(:vote).permit(:like1, :like2, :like3, :like4, :like5, :dislike1, :dislike2, :dislike3)
  end
end